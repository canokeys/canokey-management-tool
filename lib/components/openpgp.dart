import 'dart:typed_data';

import 'package:another_flushbar/flushbar.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:logging/logging.dart';

import '../drawer.dart';
import '../generated/l10n.dart';
import '../utils/NumericalRangeFormatter.dart';
import '../utils/commons.dart';
import '../utils/tlv.dart';

final log = Logger('ManagementTool:OpenPGP');

class OpenPGP extends StatefulWidget {
  static const String routeName = '/openpgp';

  @override
  _OpenPGPState createState() => _OpenPGPState();
}

class _OpenPGPState extends State<OpenPGP> {
  TextEditingController cacheTimeController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController newPinController = TextEditingController();
  OpenPGPCard card;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        titleSpacing: 0.0,
        centerTitle: true,
        title: Text('OpenPGP', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
        actions: [IconButton(icon: Icon(Icons.refresh), onPressed: refresh)],
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            if (card == null) ...[
              SizedBox(height: 25.0),
              Center(
                child: Text(S.of(context).pollCanoKey, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 25.0),
            ] else ...[
              Text(S.of(context).openpgpCardInfo, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 15.0),
              itemTile(width, Icons.add, S.of(context).openpgpVersion, card.version),
              itemTile(width, Icons.shopping_bag, S.of(context).openpgpManufacturer, card.manufacturer),
              itemTile(width, Icons.vpn_key, S.of(context).openpgpSN, card.sn),
              itemTile(width, Icons.person, S.of(context).openpgpCardHolder, card.cardHolder),
              itemTile(width, Icons.star, S.of(context).openpgpPubkeyUrl, card.publicKeyUrl),
              SizedBox(height: 25.0),
              Text(S.of(context).openpgpKeys, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 15.0),
              itemTile(width, Icons.lock_outline, S.of(context).openpgpSignature, card.signature),
              itemTile(width, Icons.lock_outline, S.of(context).openpgpEncryption, card.encryption),
              itemTile(width, Icons.lock_outline, S.of(context).openpgpAuthentication, card.authentication),
              SizedBox(height: 25.0),
              if (card.uifSig != TouchPolicy.na) ...[
                Text(S.of(context).openpgpUIF, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 15.0),
                itemTile(width, Icons.touch_app, S.of(context).openpgpSignature, card.uifSig.toText(context),
                    card.uifSig == TouchPolicy.permanent ? null : () => showChangeUifDialog(KeyType.signature, card.uifSig)),
                itemTile(width, Icons.touch_app, S.of(context).openpgpEncryption, card.uifEnc.toText(context),
                    card.uifEnc == TouchPolicy.permanent ? null : () => showChangeUifDialog(KeyType.encryption, card.uifEnc)),
                itemTile(width, Icons.touch_app, S.of(context).openpgpAuthentication, card.uifAut.toText(context),
                    card.uifAut == TouchPolicy.permanent ? null : () => showChangeUifDialog(KeyType.authentication, card.uifAut)),
                itemTile(width, Icons.timelapse, S.of(context).openpgpUifCacheTime, '${card.uifCacheTime}s', showChangeCacheTimeDialog),
                SizedBox(height: 25.0),
              ],
              Text(S.of(context).actions, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 15.0),
              Wrap(
                spacing: 15.0,
                runSpacing: 15.0,
                children: [
                  InkWell(
                    onTap: () => showChangePinDialog(PinType.pin),
                    borderRadius: BorderRadius.circular(30.0),
                    child: Material(
                      elevation: 1.0,
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.indigo),
                        child: Text(S.of(context).changePin, style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => showChangePinDialog(PinType.adminPin),
                    borderRadius: BorderRadius.circular(30.0),
                    child: Material(
                      elevation: 1.0,
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.indigo),
                        child: Text(S.of(context).openpgpChangeAdminPin,
                            style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    cacheTimeController.dispose();
    pinController.dispose();
    newPinController.dispose();
    super.dispose();
  }

  Widget itemTile(double width, IconData icon, String title, String subtitle, [Function handler]) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            hoverColor: Colors.transparent,
            onTap: handler,
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
                      Text(title, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.indigo[500])),
                      SizedBox(height: 5.0),
                      Text(subtitle, style: TextStyle(fontSize: 15.0, color: Colors.grey, fontFamily: 'Consolas')),
                    ],
                  ),
                ),
                if (handler != null)
                  Container(
                    height: 56.0,
                    width: 56.0,
                    alignment: Alignment.center,
                    child: Icon(Icons.arrow_forward_ios, size: 28.0, color: Colors.indigo[500]),
                  ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Container(width: width - 30.0, height: 1.0, margin: EdgeInsets.symmetric(horizontal: 15.0), color: Colors.grey[200]),
        ],
      ),
    );
  }

  void showChangeUifDialog(KeyType keyType, TouchPolicy currentPolicy) {
    bool tap = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          item(TouchPolicy policy) {
            return InkWell(
              onTap: () => setState(() => currentPolicy = policy),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (currentPolicy == policy) Icon(Icons.check, size: 28.0, color: Colors.indigo[500]) else SizedBox(width: 28.0, height: 28.0),
                  SizedBox(width: 20.0),
                  Text(policy.toText(context), style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            );
          }

          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(S.of(context).openpgpChangeInteraction(keyType.toText(context)), style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                Divider(color: Colors.black),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      item(TouchPolicy.off),
                      SizedBox(height: 10.0),
                      item(TouchPolicy.on),
                      SizedBox(height: 10.0),
                      item(TouchPolicy.permanent),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
                Divider(color: Colors.black),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: pinController,
                    obscureText: tap,
                    autofocus: true,
                    onSubmitted: (String pin) {
                      if (pin.isEmpty) return;
                      changeUif(keyType, currentPolicy, pin);
                    },
                    decoration: InputDecoration(
                      labelText: 'Admin PIN',
                      hintText: 'Admin PIN',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock_outlined, color: Colors.indigo[500]),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => tap = !tap),
                        icon: tap
                            ? Icon(Icons.remove_red_eye_outlined, color: Colors.indigo[500])
                            : Icon(Icons.visibility_off_outlined, color: Colors.indigo[500]),
                      ),
                    ),
                  ),
                ),
                Divider(color: Colors.black),
                Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.only(left: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => changeUif(keyType, currentPolicy, pinController.text),
                        borderRadius: BorderRadius.circular(30.0),
                        child: Material(
                          elevation: 1.0,
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.indigo),
                            child: Text(S.of(context).save, style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.0),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(30.0),
                        child: Material(
                          elevation: 1.0,
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.indigo[100]),
                            child: Text(S.of(context).close, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                          ),
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

  void showChangeCacheTimeDialog() {
    bool tap = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Center(child: Text(S.of(context).openpgpChangeTouchCacheTime, style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                Divider(color: Colors.black),
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: cacheTimeController,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    inputFormatters: [new NumericalRangeFormatter(min: 0, max: 255)],
                    decoration: InputDecoration(
                        labelText: S.of(context).openpgpUifCacheTime + ' (0 ~ 255)',
                        hintText: S.of(context).openpgpUifCacheTime + ' (0 ~ 255 ${S.of(context).seconds})',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.timelapse, color: Colors.indigo[500])),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: pinController,
                    obscureText: tap,
                    onSubmitted: (String pin) {
                      if (pin.isEmpty) return;
                      changeUifCacheTime(int.parse(cacheTimeController.text), pin);
                    },
                    decoration: InputDecoration(
                      labelText: 'Admin PIN',
                      hintText: 'Admin PIN',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock_outlined, color: Colors.indigo[500]),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => tap = !tap),
                        icon: tap
                            ? Icon(Icons.remove_red_eye_outlined, color: Colors.indigo[500])
                            : Icon(Icons.visibility_off_outlined, color: Colors.indigo[500]),
                      ),
                    ),
                  ),
                ),
                Divider(color: Colors.black),
                Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.only(left: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => changeUifCacheTime(int.parse(cacheTimeController.text), pinController.text),
                        borderRadius: BorderRadius.circular(30.0),
                        child: Material(
                          elevation: 1.0,
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.indigo),
                            child: Text(S.of(context).save, style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.0),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(30.0),
                        child: Material(
                          elevation: 1.0,
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.indigo[100]),
                            child: Text(S.of(context).close, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                          ),
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

  void showChangePinDialog(PinType pinType) {
    final newPinMinLength = pinType == PinType.adminPin ? 8 : 6;
    bool tapOldPin = true;
    bool tapNewPin = true;
    String errorText;

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
                  child: Center(
                    child: Text(S.of(context).change + (pinType == PinType.adminPin ? 'Admin' : '') + ' PIN', // Change PIN / Change Admin PIN
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                Divider(color: Colors.black),
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Text(S.of(context).changePinPrompt(6), style: TextStyle(height: 1.5, fontSize: 15.0)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: pinController,
                    obscureText: tapOldPin,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: S.of(context).oldPin,
                      hintText: S.of(context).oldPin,
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock_outlined, color: Colors.indigo[500]),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => tapOldPin = !tapOldPin),
                        icon: tapOldPin
                            ? Icon(Icons.remove_red_eye_outlined, color: Colors.indigo[500])
                            : Icon(Icons.visibility_off_outlined, color: Colors.indigo[500]),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: newPinController,
                    obscureText: tapNewPin,
                    onChanged: (newPin) => setState(() {
                      if (newPin.length < newPinMinLength || newPin.length > 64) {
                        errorText = S.of(context).pinInvalidLength;
                      } else {
                        errorText = null;
                      }
                    }),
                    decoration: InputDecoration(
                      labelText: S.of(context).newPin,
                      hintText: S.of(context).newPin,
                      errorText: errorText,
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock_outlined, color: Colors.indigo[500]),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => tapNewPin = !tapNewPin),
                        icon: tapNewPin
                            ? Icon(Icons.remove_red_eye_outlined, color: Colors.indigo[500])
                            : Icon(Icons.visibility_off_outlined, color: Colors.indigo[500]),
                      ),
                    ),
                  ),
                ),
                Divider(color: Colors.black),
                Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.only(left: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => changePin(pinType, pinController.text, newPinController.text),
                        borderRadius: BorderRadius.circular(30.0),
                        child: Material(
                          elevation: 1.0,
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.indigo),
                            child: Text(S.of(context).save, style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.0),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(30.0),
                        child: Material(
                          elevation: 1.0,
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.indigo[100]),
                            child: Text(S.of(context).close, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                          ),
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
      Commons.assertOK(await transceive('00A4040006D2760001240100'));

      // parse general info
      String resp = await transceive('00CA006E00');
      Commons.assertOK(resp);
      Map info = TLV.parse(hex.decode(Commons.dropSW(resp)));
      Uint8List aid = info[0x4F];
      String version = '${aid[6]}.${aid[7]}';
      int manufacturerId = (aid[8] << 8) | aid[9];
      String sn = hex.encode(aid.sublist(10, 14)).toUpperCase();
      String fingerprints = hex.encode(info[0x73][0xC5]).toUpperCase();
      String sigKey = fingerprints.substring(0, 40);
      if (sigKey == '0' * 40) {
        sigKey = S.of(context).openpgpKeyNone;
      } else {
        sigKey = StringUtils.addCharAtPosition(sigKey, ' ', 4, repeat: true);
      }
      String encKey = fingerprints.substring(40, 80);
      if (encKey == '0' * 40) {
        encKey = S.of(context).openpgpKeyNone;
      } else {
        encKey = StringUtils.addCharAtPosition(encKey, ' ', 4, repeat: true);
      }
      String autKey = fingerprints.substring(80, 120);
      if (autKey == '0' * 40) {
        autKey = S.of(context).openpgpKeyNone;
      } else {
        autKey = StringUtils.addCharAtPosition(autKey, ' ', 4, repeat: true);
      }

      // check if uif exists
      TouchPolicy uifSig = TouchPolicy.na;
      TouchPolicy uifEnc = TouchPolicy.na;
      TouchPolicy uifAut = TouchPolicy.na;
      int cacheTime = 0;
      if (info[0x73].containsKey(0xD6)) {
        uifSig = touchPolicyFromValue(info[0x73][0xD6][0]);
        uifEnc = touchPolicyFromValue(info[0x73][0xD7][0]);
        uifAut = touchPolicyFromValue(info[0x73][0xD8][0]);
        resp = await transceive('00CA010200');
        Commons.assertOK(resp);
        cacheTime = hex.decode(Commons.dropSW(resp))[0];
      }

      // parse personal info
      resp = await transceive('00CA5F5000');
      Commons.assertOK(resp);
      String url = String.fromCharCodes(hex.decode(Commons.dropSW(resp)));
      resp = await transceive('00CA006500');
      Commons.assertOK(resp);
      info = TLV.parse(hex.decode(Commons.dropSW(resp)));
      String name = String.fromCharCodes(info[0x5B]);

      setState(() {
        card = OpenPGPCard(version, manufacturers[manufacturerId], sn, name, url, sigKey, encKey, autKey, uifSig, uifEnc, uifAut, cacheTime);
      });
    });
  }

  void changePin(PinType pinType, String oldPin, String newPin) {
    Commons.process(context, () async {
      Commons.assertOK(await transceive('00A4040006D2760001240100'));
      int len = oldPin.length + newPin.length;
      String resp = await transceive('002400' +
          (pinType == PinType.pin ? '81' : '83') +
          len.toRadixString(16).padLeft(2, '0') +
          hex.encode(oldPin.codeUnits) +
          hex.encode(newPin.codeUnits));
      if (resp == '9000') {
        Navigator.pop(context);
        Flushbar(backgroundColor: Colors.green, message: S.of(context).pinChanged, duration: Duration(seconds: 3)).show(context);
      } else {
        Commons.promptPinFailureResult(context, resp);
      }
    });
  }

  void changeUif(KeyType keyType, TouchPolicy newPolicy, String adminPin) {
    Commons.process(context, () async {
      Commons.assertOK(await transceive('00A4040006D2760001240100'));
      if (!await verifyAdminPin(adminPin)) return;
      Commons.assertOK(
          await transceive('00DA00' + getKeyUifTag(keyType) + '02' + newPolicy.toValue().toRadixString(16).padLeft(2, '0') + '20'));
      Navigator.pop(context);
      Flushbar(backgroundColor: Colors.green, message: S.of(context).openpgpUifChanged, duration: Duration(seconds: 3)).show(context);
      refresh();
    });
  }

  void changeUifCacheTime(int cacheTime, String adminPin) {
    Commons.process(context, () async {
      await transceive('00A4040006D2760001240100');
      if (!await verifyAdminPin(adminPin)) return;
      Commons.assertOK(await transceive('00DA010201' + cacheTime.toRadixString(16).padLeft(2, '0')));
      Navigator.pop(context);
      Flushbar(backgroundColor: Colors.green, message: S.of(context).openpgpUifCacheTimeChanged, duration: Duration(seconds: 3)).show(context);
      refresh();
    });
  }

  String getKeyUifTag(KeyType keyType) {
    switch (keyType) {
      case KeyType.signature:
        return 'D6';
      case KeyType.encryption:
        return 'D7';
      case KeyType.authentication:
        return 'D8';
      default: // never happens
        return '';
    }
  }

  Future<bool> verifyAdminPin(String adminPin) async {
    String resp = await transceive('00200083' + adminPin.length.toRadixString(16).padLeft(2, '0') + hex.encode(adminPin.codeUnits));
    if (Commons.isOK(resp)) return true;
    Commons.promptPinFailureResult(context, resp);
    return false;
  }

  Future<String> transceive(String capdu) async {
    String rapdu = '';
    do {
      if (rapdu.length >= 4) {
        var remain = rapdu.substring(rapdu.length - 2);
        if (remain != '') {
          capdu = '00C00000$remain';
          rapdu = rapdu.substring(0, rapdu.length - 4);
        }
      }
      rapdu += await FlutterNfcKit.transceive(capdu);
    } while (rapdu.substring(rapdu.length - 4, rapdu.length - 2) == '61');
    return rapdu;
  }

  Map<int, String> manufacturers = {
    0x0001: 'PPC Card Systems',
    0x0002: 'Prism',
    0x0003: 'OpenFortress',
    0x0004: 'Wewid',
    0x0005: 'ZeitControl',
    0x0006: 'Yubico',
    0x0007: 'OpenKMS',
    0x0008: 'LogoEmail',
    0x0009: 'Fidesmo',
    0x000A: 'VivoKey',
    0x000B: 'Feitian Technologies',
    0x000D: 'Dangerous Things',
    0x000E: 'Excelsecu',
    0x002A: 'Magrathea',
    0x0042: 'GnuPG e.V.',
    0x1337: 'Warsaw Hackerspace',
    0x2342: 'warpzone',
    0x4354: 'Confidential Technologies',
    0x5343: 'SSE Carte à puce',
    0x5443: 'TIF-IT e.V.',
    0x63AF: 'Trustica',
    0xBA53: 'c-base e.V.',
    0xBD0E: 'Paranoidlabs',
    0xF1D0: 'CanoKeys',
    0xF517: 'FSIJ',
    0xF5EC: 'F-Secure',
  };
}

enum TouchPolicy { na, off, on, permanent }

TouchPolicy touchPolicyFromValue(int val) {
  switch (val) {
    case 0x00:
      return TouchPolicy.off;
    case 0x01:
      return TouchPolicy.on;
    case 0x02:
      return TouchPolicy.permanent;
  }
  return TouchPolicy.na;
}

extension TouchPolicyEx on TouchPolicy {
  String toText(BuildContext context) {
    switch (this) {
      case TouchPolicy.off:
        return S.of(context).openpgpUifOff;
      case TouchPolicy.on:
        return S.of(context).openpgpUifOn;
      case TouchPolicy.permanent:
        return S.of(context).openpgpUifPermanent;
      default:
        return '';
    }
  }

  int toValue() {
    switch (this) {
      case TouchPolicy.off:
        return 0x00;
      case TouchPolicy.on:
        return 0x01;
      case TouchPolicy.permanent:
        return 0x02;
      default:
        return 0xFF;
    }
  }
}

enum KeyType { signature, encryption, authentication }

extension KeyTypeEx on KeyType {
  String toText(BuildContext context) {
    switch (this) {
      case KeyType.signature:
        return S.of(context).openpgpSignature;
      case KeyType.encryption:
        return S.of(context).openpgpEncryption;
      case KeyType.authentication:
        return S.of(context).openpgpAuthentication;
      default:
        return '';
    }
  }
}

enum PinType { pin, adminPin }

class OpenPGPCard {
  final String version;
  final String manufacturer;
  final String sn;
  final String cardHolder;
  final String publicKeyUrl;
  final String signature;
  final String encryption;
  final String authentication;
  final TouchPolicy uifSig;
  final TouchPolicy uifEnc;
  final TouchPolicy uifAut;
  final int uifCacheTime;

  OpenPGPCard(this.version, this.manufacturer, this.sn, this.cardHolder, this.publicKeyUrl, this.signature, this.encryption, this.authentication,
      this.uifSig, this.uifEnc, this.uifAut, this.uifCacheTime);
}
