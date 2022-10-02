import 'dart:convert';

import 'package:base32/base32.dart';
import 'package:circular_countdown/circular_countdown.dart';
import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:logging/logging.dart';
import 'package:timer_controller/timer_controller.dart';

import '../drawer.dart';
import '../generated/l10n.dart';
import '../utils/NumericalRangeFormatter.dart';
import '../utils/commons.dart';
import '../utils/tlv.dart';

final log = Logger('ManagementTool:OATH');

class OATH extends StatefulWidget {
  static const String routeName = '/oath';

  @override
  _OATHState createState() => _OATHState();
}

class _OATHState extends State<OATH> {
  bool polled = false;
  List<OathItem> items = [];
  Version version = Version.v1;
  TimerController timerController = TimerController.seconds(30);
  TextEditingController issuerController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController secretKeyController = TextEditingController();
  TextEditingController periodController = TextEditingController(text: '30');
  TextEditingController counterController = TextEditingController(text: '0');
  TextEditingController codeController = TextEditingController();
  TextEditingController newCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        titleSpacing: 0.0,
        centerTitle: true,
        title: Text('TOTP / HOTP', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(value: 0, child: Text(S.of(context).add)),
              if (version == Version.v1) PopupMenuItem(value: 1, child: Text(S.of(context).oathSetCode)),
            ],
            onSelected: (idx) async {
              if (idx == 0) {
                showAddDialog();
              } else if (idx == 1) {
                if (version == Version.v1) showSetCodeDialog();
              }
            },
            icon: Icon(Icons.more_vert),
          ),
          IconButton(icon: Icon(Icons.refresh), onPressed: refresh),
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            if (!polled) ...[
              SizedBox(height: 25.0),
              Center(
                child: Text(S.of(context).pollCanoKey, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 25.0),
            ] else ...[
              TimerControllerListener(
                  controller: timerController,
                  listener: (_, TimerValue value) {
                    if (value.status == TimerStatus.finished) refresh();
                  },
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) =>
                        itemTile(width, Icons.pin, items[index].code, items[index].name, items[index].requireTouch, items[index].type),
                  )),
            ]
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    issuerController.dispose();
    accountController.dispose();
    secretKeyController.dispose();
    periodController.dispose();
    timerController.dispose();
    codeController.dispose();
    newCodeController.dispose();
    super.dispose();
  }

  Widget itemTile(double width, IconData icon, String code, String name, bool requireTouch, Type type) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            hoverColor: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 56.0,
                  width: 56.0,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(28.0), color: Colors.grey[300]),
                  alignment: Alignment.center,
                  child: Icon(icon, size: 28.0, color: Colors.indigo[500]),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(code.isEmpty ? '*** ***' : code, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.indigo[500])),
                      SizedBox(height: 5.0),
                      Text(name, style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                    ],
                  ),
                ),
                if (requireTouch)
                  InkWell(
                    onTap: () => calculate(name, type),
                    child: Container(
                      height: 56.0,
                      width: 56.0,
                      alignment: Alignment.center,
                      child: Icon(Icons.touch_app, size: 28.0, color: Colors.indigo[500]),
                    ),
                  ),
                if (type == Type.hotp)
                  InkWell(
                    onTap: () => calculate(name, type),
                    child: Container(
                      height: 56.0,
                      width: 56.0,
                      alignment: Alignment.center,
                      child: Icon(Icons.refresh, size: 28.0, color: Colors.indigo[500]),
                    ),
                  ),
                PopupMenuButton(
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(value: 0, child: Text(S.of(context).oathCopy)),
                    PopupMenuItem(value: 1, child: Text(S.of(context).delete)),
                    if (type == Type.hotp) PopupMenuItem(value: 2, child: Text(S.of(context).oathSetDefault)),
                  ],
                  onSelected: (idx) async {
                    if (idx == 0) {
                      // copy
                      if (code.isEmpty) {
                        code = await calculate(name, type);
                      }
                      Clipboard.setData(ClipboardData(text: code));
                    } else if (idx == 1) {
                      // delete
                      showDeleteDialog(name);
                    } else if (idx == 2) {
                      // set default
                      setDefault(name);
                    }
                  },
                  icon: Icon(Icons.more_horiz, size: 28.0, color: Colors.indigo[500]),
                ),
                if (type == Type.totp && code.isNotEmpty)
                  TimerControllerBuilder(
                      controller: timerController,
                      builder: (_, TimerValue value, __) => CircularCountdown(
                            diameter: 28,
                            strokeWidth: 8,
                            countdownTotal: 30,
                            countdownRemaining: value.remaining,
                            countdownRemainingColor: const Color(0xFF4F6367),
                            countdownTotalColor: Colors.transparent,
                            countdownCurrentColor: Colors.green,
                          )),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Container(width: width - 30.0, height: 1.0, margin: EdgeInsets.symmetric(horizontal: 15.0), color: Colors.grey[200]),
        ],
      ),
    );
  }

  void showAddDialog() {
    Type type = Type.totp;
    Algorithm algo = Algorithm.sha1;
    int digits = 6;
    bool requireTouch = false;
    String? accountErrorText, secretKeyErrorText, periodErrorText, counterErrorText;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => Dialog(
                elevation: 0.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: Wrap(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(S.of(context).oathAddAccount, style: TextStyle(fontWeight: FontWeight.bold)),
                          Divider(color: Colors.black),
                          SizedBox(height: 10.0),
                          Container(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: TextField(
                              controller: issuerController,
                              decoration: InputDecoration(labelText: S.of(context).oathIssuer),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: TextField(
                              controller: accountController,
                              decoration: InputDecoration(labelText: S.of(context).oathAccount, errorText: accountErrorText),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: TextField(
                              controller: secretKeyController,
                              decoration: InputDecoration(labelText: S.of(context).oathSecret, errorText: secretKeyErrorText),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Wrap(
                              spacing: 15.0,
                              runSpacing: 15.0,
                              children: [
                                FractionallySizedBox(
                                  widthFactor: 0.45,
                                  child: DropdownButtonFormField<Type>(
                                    isExpanded: true,
                                    decoration: InputDecoration(labelText: S.of(context).oathType),
                                    value: type,
                                    items: [
                                      DropdownMenuItem(child: Text('TOTP'), value: Type.totp),
                                      DropdownMenuItem(child: Text('HOTP'), value: Type.hotp),
                                    ],
                                    onChanged: (e) => {
                                      setState(() => {type = e!})
                                    },
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: 0.45,
                                  child: DropdownButtonFormField<Algorithm>(
                                    isExpanded: true,
                                    decoration: InputDecoration(labelText: S.of(context).oathAlgorithm),
                                    value: algo,
                                    items: [
                                      DropdownMenuItem(child: Text('SHA-1'), value: Algorithm.sha1),
                                      DropdownMenuItem(child: Text('SHA-256'), value: Algorithm.sha256),
                                      DropdownMenuItem(child: Text('SHA-512'), value: Algorithm.sha512),
                                    ],
                                    onChanged: (e) => {algo = e!},
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: 0.45,
                                  child: DropdownButtonFormField<int>(
                                    isExpanded: true,
                                    decoration: InputDecoration(labelText: S.of(context).oathDigits),
                                    value: digits,
                                    items: [
                                      DropdownMenuItem(child: Text('5'), value: 5),
                                      DropdownMenuItem(child: Text('6'), value: 6),
                                      DropdownMenuItem(child: Text('7'), value: 7),
                                      DropdownMenuItem(child: Text('8'), value: 8),
                                    ],
                                    onChanged: (e) => {digits = e!},
                                  ),
                                ),
                                if (type == Type.totp)
                                  FractionallySizedBox(
                                    widthFactor: 0.45,
                                    child: TextField(
                                      controller: periodController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [new NumericalRangeFormatter(min: 1, max: 99)],
                                      decoration: InputDecoration(labelText: S.of(context).oathPeriod, errorText: periodErrorText),
                                      style: TextStyle(fontSize: 19),
                                    ),
                                  )
                                else
                                  FractionallySizedBox(
                                    widthFactor: 0.45,
                                    child: TextField(
                                      controller: counterController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(labelText: S.of(context).oathCounter, errorText: counterErrorText),
                                      style: TextStyle(fontSize: 19),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (type == Type.totp)
                            Container(
                              padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
                              child: CheckboxListTile(
                                value: requireTouch,
                                onChanged: (e) => setState(() => requireTouch = e!),
                                title: Text(S.of(context).oathRequireTouch),
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(S.of(context).cancel, style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  String account = '', secretKey = '', period = '', counter = '';
                                  if (accountController.text.isEmpty) account = S.of(context).oathRequired;
                                  if (accountController.text.length + issuerController.text.length > 63) account = S.of(context).oathTooLong;
                                  if (secretKeyController.text.isEmpty) secretKey = S.of(context).oathRequired;
                                  if (secretKeyController.text.length > 52) secretKey = S.of(context).oathTooLong;
                                  late String secretHex;
                                  try {
                                    secretHex = base32.decodeAsHexString(secretKeyController.text.toUpperCase());
                                  } catch (e) {
                                    secretKey = S.of(context).oathInvalidKey;
                                  }
                                  if (type == Type.totp && periodController.text.isEmpty) period = S.of(context).oathRequired;
                                  if (type == Type.hotp && counterController.text.isEmpty) counter = S.of(context).oathRequired;
                                  if (type == Type.totp && int.tryParse(periodController.text) == null)
                                    period = S.of(context).oathCounterMustBeNumber;
                                  if (type == Type.hotp && int.tryParse(counterController.text) == null)
                                    counter = S.of(context).oathCounterMustBeNumber;

                                  setState(() {
                                    accountErrorText = account.isEmpty ? null : account;
                                    secretKeyErrorText = secretKey.isEmpty ? null : secretKey;
                                    periodErrorText = period.isEmpty ? null : period;
                                    counterErrorText = counter.isEmpty ? null : counter;
                                  });

                                  if (account.isEmpty && secretKey.isEmpty && period.isEmpty && counter.isEmpty) {
                                    String name = accountController.text;
                                    if (issuerController.text.isNotEmpty) name = issuerController.text + ':' + name;
                                    addAccount(name, secretHex, type, algo, digits, int.parse(periodController.text),
                                        int.parse(counterController.text), requireTouch);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(),
                                  child: Text(S.of(context).confirm, style: TextStyle(color: Colors.indigo[500], fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ))));
  }

  void showDeleteDialog(String name) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext _) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(S.of(context).warning, style: TextStyle(fontWeight: FontWeight.bold)),
                      Divider(color: Colors.black),
                      SizedBox(height: 10.0),
                      Text(S.of(context).oathDelete(name)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10.0),
                              child: Text(S.of(context).cancel, style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          InkWell(
                            onTap: () => delete(name),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(),
                              child: Text(S.of(context).delete, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  void showInputCodeDialog() {
    bool tapPin = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext _) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Center(child: Text(S.of(context).oathInputCode, style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Text(S.of(context).oathInputCodePrompt, style: TextStyle(height: 1.5, fontSize: 15.0)),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: codeController,
                    obscureText: tapPin,
                    autofocus: true,
                    onSubmitted: (String pin) {
                      if (pin.isEmpty) return;
                      refresh();
                      Navigator.pop(context);
                    },
                    decoration: InputDecoration(
                      labelText: S.of(context).oathCode,
                      hintText: S.of(context).oathCode,
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock_outlined, color: Colors.indigo[500]),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => tapPin = !tapPin),
                        icon: tapPin
                            ? Icon(Icons.remove_red_eye_outlined, color: Colors.indigo[500])
                            : Icon(Icons.visibility_off_outlined, color: Colors.indigo[500]),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10.0),
                          child: Text(S.of(context).cancel, style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          refresh();
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10.0),
                          child: Text(S.of(context).confirm, style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  void showSetCodeDialog() {
    bool tapNewCode = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext _) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Center(child: Text(S.of(context).oathSetCode, style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Text(S.of(context).oathNewCodePrompt, style: TextStyle(height: 1.5, fontSize: 15.0)),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: newCodeController,
                    obscureText: tapNewCode,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: S.of(context).oathNewCode,
                      hintText: S.of(context).oathNewCode,
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock_outlined, color: Colors.indigo[500]),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => tapNewCode = !tapNewCode),
                        icon: tapNewCode
                            ? Icon(Icons.remove_red_eye_outlined, color: Colors.indigo[500])
                            : Icon(Icons.visibility_off_outlined, color: Colors.indigo[500]),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10.0),
                          child: Text(S.of(context).close, style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      InkWell(
                        onTap: () => setCode(newCodeController.text),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10.0),
                          child: Text(S.of(context).save, style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  void refresh() {
    Commons.process(context, () async {
      String resp = await transceive('00A4040007A0000005272101');
      Commons.assertOK(resp);
      if (resp == '9000') {
        version = Version.legacy;
      } else {
        Map info = TLV.parse(hex.decode(Commons.dropSW(resp)));
        if (hex.encode(info[0x79]) == '050505') {
          version = Version.v1;
          if (info.containsKey(0x74)) {
            if (codeController.text.isEmpty) {
              // without a pin
              showInputCodeDialog();
              return;
            } else {
              final hmacSha1 = Hmac(Sha1());
              final pbkdf2 = Pbkdf2(macAlgorithm: hmacSha1, iterations: 1000, bits: 128);
              final key = await pbkdf2.deriveKey(secretKey: SecretKey(utf8.encode(codeController.text)), nonce: info[0x71]);
              final mac = await hmacSha1.calculateMac(info[0x74], secretKey: key);
              resp = await transceive('00A300001C7514${hex.encode(mac.bytes)}740400000000');
              Commons.assertOK(resp);
            }
          }
        }
      }
      int challenge = DateTime.now().millisecondsSinceEpoch ~/ 30000;
      String challengeStr = challenge.toRadixString(16).padLeft(16, '0');
      if (version == Version.v1) {
        resp = await transceive('00A400010A7408$challengeStr');
      } else {
        resp = await transceive('000500000A7408$challengeStr');
      }
      Commons.assertOK(resp);
      List<int> data = hex.decode(Commons.dropSW(resp));
      setState(() {
        polled = true;
        items = parseV1(data);
        int running = DateTime.now().millisecondsSinceEpoch ~/ 1000 % 30;
        timerController.value = new TimerValue(remaining: 30 - running, unit: TimerUnit.second);
        timerController.start();
      });
    });
  }

  void addAccount(String name, String key, Type type, Algorithm algo, int digits, int period, int initValue, bool requireTouch) {
    Commons.process(context, () async {
      String resp = await transceive('00A4040007A0000005272101');
      Commons.assertOK(resp);

      List<int> nameBytes = utf8.encode(name);
      String capduData = '71' + nameBytes.length.toRadixString(16).padLeft(2, '0') + hex.encode(nameBytes); // name 0x71
      capduData += '73' +
          (key.length ~/ 2 + 2).toRadixString(16).padLeft(2, '0') + // length
          (type.toValue() | algo.toValue()).toRadixString(16).padLeft(2, '0') + // type & algo
          digits.toRadixString(16).padLeft(2, '0') + // digits
          key;
      if (requireTouch) {
        if (version == Version.legacy)
          capduData += '780102';
        else
          capduData += '7802';
      }
      if (initValue > 0) capduData += '7A04' + initValue.toRadixString(16).padLeft(4, '0');

      resp = await transceive('00010000' + (capduData.length ~/ 2).toRadixString(16).padLeft(2, '0') + capduData);
      Commons.assertOK(resp);
      issuerController.text = '';
      accountController.text = '';
      secretKeyController.text = '';
      periodController.text = '30';
      counterController.text = '0';
      Commons.promptSuccess(S.of(context).oathAdded);
      Navigator.pop(context);
      refresh();
    });
  }

  Future<String> calculate(String name, Type type) async {
    late String code;
    await Commons.process(context, () async {
      String resp = await transceive('00A4040007A0000005272101');
      Commons.assertOK(resp);
      List<int> nameBytes = utf8.encode(name);
      String capduData = '71' + nameBytes.length.toRadixString(16).padLeft(2, '0') + hex.encode(nameBytes);
      if (type == Type.totp) {
        int challenge = DateTime.now().millisecondsSinceEpoch ~/ 30000;
        String challengeStr = challenge.toRadixString(16).padLeft(16, '0');
        capduData += '7408$challengeStr';
      }
      if (version == Version.v1) {
        resp = await transceive('00A20001' + (capduData.length ~/ 2).toRadixString(16).padLeft(2, '0') + capduData);
      } else {
        resp = await transceive('00040000' + (capduData.length ~/ 2).toRadixString(16).padLeft(2, '0') + capduData);
      }
      Commons.assertOK(resp);
      List<int> data = hex.decode(Commons.dropSW(resp));
      code = parseResponse(data.sublist(2));
      setState(() {
        items.firstWhere((e) => e.name == name).code = code;
      });
    });
    return code;
  }

  void delete(String name) {
    Commons.process(context, () async {
      String resp = await transceive('00A4040007A0000005272101');
      Commons.assertOK(resp);
      List<int> nameBytes = utf8.encode(name);
      String capduData = '71' + nameBytes.length.toRadixString(16).padLeft(2, '0') + hex.encode(nameBytes);
      Commons.assertOK(await transceive('00020000' + (capduData.length ~/ 2).toRadixString(16).padLeft(2, '0') + capduData));
      Commons.promptSuccess(S.of(context).oathDeleted);
      Navigator.pop(context);
      refresh();
    });
  }

  void setCode(String code) {
    Commons.process(context, () async {
      String resp = await transceive('00A4040007A0000005272101');
      Commons.assertOK(resp);
      if (resp == '9000') {
        return;
      } else {
        Map info = TLV.parse(hex.decode(Commons.dropSW(resp)));
        if (hex.encode(info[0x79]) == '050505') {
          if (code.isEmpty) {
            resp = await transceive('00030000027300');
          } else {
            final hmacSha1 = Hmac(Sha1());
            final pbkdf2 = Pbkdf2(macAlgorithm: hmacSha1, iterations: 1000, bits: 128);
            final key = await pbkdf2.deriveKey(secretKey: SecretKey(utf8.encode(code)), nonce: info[0x71]);
            final keyString = hex.encode(await key.extractBytes());
            final mac = await hmacSha1.calculateMac(List.of([0, 0, 0, 0]), secretKey: key);
            resp = await transceive('000300002F731101${keyString}7404000000007514${hex.encode(mac.bytes)}');
          }
          Commons.assertOK(resp);
          codeController.text = code;
          Commons.promptSuccess(S.of(context).oathCodeChanged);
          Navigator.pop(context);
        }
      }
    });
  }

  void setDefault(String name) {
    Commons.process(context, () async {
      String resp = await transceive('00A4040007A0000005272101');
      Commons.assertOK(resp);
      List<int> nameBytes = utf8.encode(name);
      String capduData = '71' + nameBytes.length.toRadixString(16).padLeft(2, '0') + hex.encode(nameBytes);
      Commons.assertOK(await transceive('00550000' + (capduData.length ~/ 2).toRadixString(16).padLeft(2, '0') + capduData));
      Commons.promptSuccess(S.of(context).successfullyChanged);
      refresh();
    });
  }

  List<OathItem> parseV1(List<int> data) {
    List<OathItem> result = [];
    int pos = 0;
    while (pos < data.length) {
      OathItem item = parseSingleV1(data.sublist(pos));
      pos += item._length;
      result.add(item);
    }
    return result;
  }

  OathItem parseSingleV1(List<int> data) {
    assert(data.length >= 4);
    assert(data[0] == 0x71);
    int nameLen = data[1];
    assert(4 + nameLen <= data.length);
    String name = utf8.decode(data.sublist(2, 2 + nameLen));
    int dataLen = data[3 + nameLen];
    assert(4 + nameLen + dataLen <= data.length);
    OathItem item = OathItem(name);
    item._length = nameLen + dataLen + 4;
    switch (data[2 + nameLen]) {
      case 0x76: // response
        item.code = parseResponse(data.sublist(4 + nameLen, 4 + nameLen + dataLen));
        break;
      case 0x77: // hotp
        item.type = Type.hotp;
        break;
      case 0x7C: // touch
        item.requireTouch = true;
        break;
      default:
        throw Exception('Illegal tag');
    }
    return item;
  }

  String parseResponse(List<int> resp) {
    assert(resp.length == 5);
    int digits = resp[0];
    int rawCode = (resp[1] << 24) | (resp[2] << 16) | (resp[3] << 8) | resp[4];
    int code = rawCode % digitsPower[digits];
    return code.toString().padLeft(digits, '0');
  }

  Future<String> transceive(String capdu) async {
    String rapdu = '';
    do {
      if (rapdu.length >= 4) {
        var remain = rapdu.substring(rapdu.length - 2);
        if (remain != '') {
          if (version == Version.legacy)
            capdu = '00060000$remain';
          else if (version == Version.v1) capdu = '00A50000$remain';
          rapdu = rapdu.substring(0, rapdu.length - 4);
        }
      }
      rapdu += await FlutterNfcKit.transceive(capdu);
    } while (rapdu.substring(rapdu.length - 4, rapdu.length - 2) == '61');
    return rapdu;
  }

  List<int> digitsPower = [1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000];
}

enum Version { legacy, v1 }

enum Type { hotp, totp }

extension TypeEx on Type {
  int toValue() {
    switch (this) {
      case Type.hotp:
        return 0x10;
      case Type.totp:
        return 0x20;
      default:
        return 0;
    }
  }
}

enum Algorithm { sha1, sha256, sha512 }

extension AlgorithmEx on Algorithm {
  int toValue() {
    switch (this) {
      case Algorithm.sha1:
        return 0x01;
      case Algorithm.sha256:
        return 0x02;
      case Algorithm.sha512:
        return 0x03;
      default:
        return 0;
    }
  }
}

class OathItem {
  String name;
  Type type = Type.totp;
  bool requireTouch = false;
  String code = '';
  int _length = 0;

  OathItem(this.name);
}
