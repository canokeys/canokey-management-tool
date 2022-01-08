import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:logging/logging.dart';

import '../drawer.dart';
import '../generated/l10n.dart';
import '../utils/NumericalRangeFormatter.dart';
import '../utils/apdu.dart';
import '../utils/tlv.dart';

final log = Logger('ManagementTool:OpenPGP');

class OpenPGP extends StatefulWidget {
  static const String routeName = '/openpgp';

  @override
  _OpenPGPState createState() => _OpenPGPState();
}

class _OpenPGPState extends State<OpenPGP> {
  OpenPGPCard _card;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        titleSpacing: 0.0,
        centerTitle: true,
        title: Text('OpenPGP', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
        actions: [IconButton(icon: Icon(Icons.refresh), onPressed: _refresh)],
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            if (_card == null) ...[
              SizedBox(height: 25.0),
              Center(
                child: Text(S.of(context).openpgpPrompt, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
              )
            ] else ...[
              Text(S.of(context).openpgpCardInfo, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 15.0),
              itemTile(width, Icons.add, S.of(context).openpgpVersion, _card.version),
              itemTile(width, Icons.shopping_bag, S.of(context).openpgpManufacturer, _card.manufacturer),
              itemTile(width, Icons.vpn_key, S.of(context).openpgpSN, _card.sn),
              itemTile(width, Icons.person, S.of(context).openpgpCardHolder, _card.cardHolder),
              itemTile(width, Icons.star, S.of(context).openpgpPubkeyUrl, _card.publicKeyUrl),
              SizedBox(height: 25.0),
              Text(S.of(context).openpgpKeys, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 15.0),
              itemTile(width, Icons.lock_outline, S.of(context).openpgpSignature, _card.signature),
              itemTile(width, Icons.lock_outline, S.of(context).openpgpEncryption, _card.encryption),
              itemTile(width, Icons.lock_outline, S.of(context).openpgpAuthentication, _card.authentication),
              SizedBox(height: 25.0),
              if (_card.uifSig != TouchPolicy.na) ...[
                Text(S.of(context).openpgpUIF, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 15.0),
                itemTile(width, Icons.touch_app, S.of(context).openpgpSignature, _card.uifSig.toText(context),
                    _card.uifSig == TouchPolicy.permanent ? null : () => showChangeUifDialog(KeyType.signature, _card.uifSig)),
                itemTile(width, Icons.touch_app, S.of(context).openpgpEncryption, _card.uifEnc.toText(context),
                    _card.uifEnc == TouchPolicy.permanent ? null : () => showChangeUifDialog(KeyType.encryption, _card.uifEnc)),
                itemTile(width, Icons.touch_app, S.of(context).openpgpAuthentication, _card.uifAut.toText(context),
                    _card.uifAut == TouchPolicy.permanent ? null : () => showChangeUifDialog(KeyType.authentication, _card.uifAut)),
                itemTile(width, Icons.timelapse, S.of(context).openpgpUifCacheTime, '${_card.uifCacheTime}s', () => showChangeCacheTimeDialog()),
                SizedBox(height: 25.0),
              ],
              Text(S.of(context).openpgpActions, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
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
                        child:
                            Text(S.of(context).openpgpChangePin, style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)),
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

  itemTile(double width, IconData icon, String title, String subtitle, [Function handler]) {
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

  showChangeUifDialog(KeyType keyType, TouchPolicy currentPolicy) {
    final adminPinController = TextEditingController();
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

          divider() {
            return Container(width: double.infinity, height: 1.0, color: Colors.grey);
          }

          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Center(child: Text("Change $keyType Key's Interaction", style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                divider(),
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
                divider(),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: adminPinController,
                    obscureText: tap,
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
                divider(),
                Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.only(left: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => _changeUif(keyType, currentPolicy, adminPinController.text),
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

  showChangeCacheTimeDialog() {
    final cacheTimeController = TextEditingController();
    final adminPinController = TextEditingController();
    bool tap = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          divider() {
            return Container(width: double.infinity, height: 1.0, color: Colors.grey);
          }

          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Center(child: Text("Change Touch Cache Time", style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                divider(),
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: cacheTimeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [new NumericalRangeFormatter(min: 0, max: 255)],
                    decoration: InputDecoration(
                        labelText: 'Cache Time (0 ~ 255)',
                        hintText: 'Cache Time (0 ~ 255)',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.timelapse, color: Colors.indigo[500])),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: adminPinController,
                    obscureText: tap,
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
                divider(),
                Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.only(left: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => _changeUifCacheTime(int.parse(cacheTimeController.text), adminPinController.text),
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

  showChangePinDialog(PinType pinType) {
    final oldPinController = TextEditingController();
    final newPinController = TextEditingController();
    bool tapOldPin = true;
    bool tapNewPin = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext _) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          divider() {
            return Container(width: double.infinity, height: 1.0, color: Colors.grey);
          }

          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Text('Change ${pinType == PinType.adminPin ? 'Admin' : ''} PIN', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                divider(),
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: oldPinController,
                    obscureText: tapOldPin,
                    decoration: InputDecoration(
                      labelText: 'Old PIN',
                      hintText: 'Old PIN',
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
                    decoration: InputDecoration(
                      labelText: 'New PIN',
                      hintText: 'New PIN',
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
                divider(),
                Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.only(left: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => _changePin(pinType, oldPinController.text, newPinController.text),
                        borderRadius: BorderRadius.circular(30.0),
                        child: Material(
                          elevation: 1.0,
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.indigo),
                            child: Text('Change', style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)),
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
                            child: Text('Close', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
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

  _refresh() async {
    await FlutterNfcKit.poll();
    await FlutterNfcKit.transceive('00A4040006D2760001240100');

    // parse general info
    String resp = await FlutterNfcKit.transceive('00CA006E00');
    Map info = TLV.parse(APDU.dropSW(hex.decode(resp)));
    Uint8List aid = info[0x4F];
    String version = '${aid[6]}.${aid[7]}';
    int manufacturerId = (aid[8] << 8) | aid[9];
    String sn = hex.encode(aid.sublist(10, 14)).toUpperCase();
    String fingerprints = hex.encode(info[0x73][0xC5]).toUpperCase();
    String sigKey = fingerprints.substring(0, 40);
    if (sigKey == '0' * 40) {
      sigKey = '[none]';
    } else {
      sigKey = StringUtils.addCharAtPosition(sigKey, ' ', 4, repeat: true);
    }
    String encKey = fingerprints.substring(40, 80);
    if (encKey == '0' * 40) {
      encKey = '[none]';
    } else {
      encKey = StringUtils.addCharAtPosition(encKey, ' ', 4, repeat: true);
    }
    String autKey = fingerprints.substring(80, 120);
    if (autKey == '0' * 40) {
      autKey = '[none]';
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
      cacheTime = hex.decode(await FlutterNfcKit.transceive('00CA010200'))[0];
    }
    // parse personal info
    resp = await FlutterNfcKit.transceive('00CA5F5000');
    String url = String.fromCharCodes(APDU.dropSW(hex.decode(resp)));
    resp = await FlutterNfcKit.transceive('00CA006500');
    info = TLV.parse(APDU.dropSW(hex.decode(resp)));
    String name = String.fromCharCodes(info[0x5B]);
    FlutterNfcKit.finish();

    setState(() {
      _card = OpenPGPCard(version, _manufacturers[manufacturerId], sn, name, url, sigKey, encKey, autKey, uifSig, uifEnc, uifAut, cacheTime);
    });
  }

  void _changePin(PinType pinType, String oldPin, String newPin) async {
    try {
      await FlutterNfcKit.poll();
      await FlutterNfcKit.transceive('00A4040006D2760001240100');
      int len = oldPin.length + newPin.length;
      String resp = await FlutterNfcKit.transceive('002400' +
          (pinType == PinType.pin ? '81' : '83') +
          len.toRadixString(16).padLeft(2, '0') +
          hex.encode(oldPin.codeUnits) +
          hex.encode(newPin.codeUnits));
      FlutterNfcKit.finish();

      if (resp == '9000') {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            content: Text('PIN has been successfully changed'),
          ),
        );
      } else if (resp == '6983') {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            content: Text('OpenPGP has been blocked'),
          ),
        );
      } else if (resp == '6982') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            content: Text(S.of(context).openpgpOldPinIncorrect),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            content: Text('Unknown response'),
          ),
        );
      }
    } catch (e) {
      log.warning(e.toDetailString());
    }
  }

  void _changeUif(KeyType keyType, TouchPolicy newPolicy, String adminPin) async {
    try {
      await FlutterNfcKit.poll();
      await FlutterNfcKit.transceive('00A4040006D2760001240100');
      String resp = await FlutterNfcKit.transceive('00200083' + adminPin.length.toRadixString(16).padLeft(2, '0') + hex.encode(adminPin.codeUnits));
      // TODO check pin verification result
      resp = await FlutterNfcKit.transceive('00DA00' + _getKeyUifTag(keyType) + '02' + newPolicy.toValue().toRadixString(16).padLeft(2, '0') + '20');
      FlutterNfcKit.finish();

      if (resp == '9000') {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            content: Text(S.of(context).openpgpUifChanged),
          ),
        );
        _refresh();
      }
    } catch (e) {
      log.warning(e.toDetailString());
    }
  }

  void _changeUifCacheTime(int cacheTime, String adminPin) async {
    try {
      await FlutterNfcKit.poll();
      await FlutterNfcKit.transceive('00A4040006D2760001240100');
      String resp = await FlutterNfcKit.transceive('00200083' + adminPin.length.toRadixString(16).padLeft(2, '0') + hex.encode(adminPin.codeUnits));
      resp = await FlutterNfcKit.transceive('00DA010201' + cacheTime.toRadixString(16).padLeft(2, '0'));
      FlutterNfcKit.finish();

      if (resp == '9000') {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            content: Text(S.of(context).openpgpUifCacheTimeChanged),
          ),
        );
        _refresh();
      }
    } catch (e) {
      log.warning(e.toDetailString());
    }
  }

  String _getKeyUifTag(KeyType keyType) {
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
}

Map<int, String> _manufacturers = {
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
