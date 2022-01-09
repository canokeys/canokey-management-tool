import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:logging/logging.dart';

import '../drawer.dart';
import '../generated/l10n.dart';
import '../utils/commons.dart';

final log = Logger('ManagementTool:Settings');

class Settings extends StatefulWidget {
  static const String routeName = '/settings';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  CanoKey _key;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        titleSpacing: 0.0,
        centerTitle: true,
        title: Text(S.of(context).settings, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
        actions: [IconButton(icon: Icon(Icons.refresh), onPressed: _showInputPinDialog)],
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            if (_key == null) ...[
              SizedBox(height: 30.0),
              Center(
                child: Text(S.of(context).pollCanoKey, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 30.0),
            ] else ...[
              Text(S.of(context).settingsInfo, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 15.0),
              _itemTile(width, Icons.mode, S.of(context).settingsModel, _key.model),
              _itemTile(width, Icons.info, S.of(context).settingsFirmwareVersion, _key.firmwareVersion),
              _itemTile(width, Icons.vpn_key, S.of(context).settingsSN, _key.sn),
              _itemTile(width, Icons.memory, S.of(context).settingsChipId, _key.chipId),
              _itemTile(width, Icons.light_mode, 'LED', _key.ledOn ? S.of(context).on : S.of(context).off),
              _itemTile(width, Icons.keyboard_alt_outlined, S.of(context).settingsHotp, _key.hotpOn ? S.of(context).on : S.of(context).off),
              if (_key.functionSet() == FunctionSet.v2)
                _itemTile(width, Icons.web, S.of(context).settingsWebUSB, _key.webusbLandingEnabled ? S.of(context).on : S.of(context).off),
              if (_key.functionSet() == FunctionSet.v2)
                _itemTile(width, Icons.nfc, S.of(context).settingsNDEF, _key.ndefEnabled ? S.of(context).on : S.of(context).off),
              _itemTile(width, Icons.brush, S.of(context).settingsNDEFReadonly, _key.ndefReadonly ? S.of(context).on : S.of(context).off),
              if (_key.functionSet() == FunctionSet.v1) ...[
                SizedBox(height: 25.0),
                Text('OpenPGP ' + S.of(context).openpgpUIF, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 15.0),
                _itemTile(width, Icons.brush, S.of(context).openpgpSignature, _key.sigTouch ? S.of(context).on : S.of(context).off),
                _itemTile(width, Icons.brush, S.of(context).openpgpEncryption, _key.decTouch ? S.of(context).on : S.of(context).off),
                _itemTile(width, Icons.brush, S.of(context).openpgpAuthentication, _key.autTouch ? S.of(context).on : S.of(context).off),
                _itemTile(width, Icons.brush, S.of(context).openpgpUifCacheTime, _key.touchCacheTime.toString()),
              ]
            ],
            Text(S.of(context).actions, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 15.0),
            Wrap(
              spacing: 15.0,
              runSpacing: 15.0,
              children: [
                InkWell(
                  onTap: _showResetDialog,
                  borderRadius: BorderRadius.circular(30.0),
                  child: Material(
                    elevation: 1.0,
                    borderRadius: BorderRadius.circular(30.0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.red),
                      child: Text(S.of(context).settingsReset, style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.0),
            Text(S.of(context).settingsOtherSettings, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
            _itemTile(width, Icons.language, S.of(context).settingsLanguage, '简体中文', () => _showChangeLanguageDialog('简体中文')),
          ],
        ),
      ),
    );
  }

  Widget _itemTile(double width, IconData icon, String title, String subtitle, [Function handler]) {
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

  void _showInputPinDialog() {
    final pinController = TextEditingController();
    bool tapPin = true;

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
                    child: Text(S.of(context).settingsInputPin, style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                divider(),
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Text(S.of(context).settingsInputPinPrompt, style: TextStyle(height: 1.5, fontSize: 15.0)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: pinController,
                    obscureText: tapPin,
                    decoration: InputDecoration(
                      labelText: "PIN",
                      hintText: "PIN",
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
                divider(),
                Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.only(left: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => _refresh(pinController.text),
                        borderRadius: BorderRadius.circular(30.0),
                        child: Material(
                          elevation: 1.0,
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.indigo),
                            child: Text(S.of(context).confirm, style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)),
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

  void _showResetDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
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
                    Text("警告", style: TextStyle(fontWeight: FontWeight.bold)),
                    Divider(color: Colors.black),
                    SizedBox(height: 10.0),
                    Text('即将抹除全部数据。当您确认后，CanoKey 将会反复闪烁，请在闪烁时触摸，直到提示成功。'),
                    SizedBox(height: 10.0),
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
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(),
                            child: Text(S.of(context).settingsReset, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
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
      },
    );
  }

  void _showChangeLanguageDialog(String currentLanguage) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          item(String language) {
            return InkWell(
              onTap: () => setState(() => currentLanguage = language),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (currentLanguage == language) Icon(Icons.check, size: 28.0, color: Colors.indigo[500]) else SizedBox(width: 28.0, height: 28.0),
                  SizedBox(width: 20.0),
                  Text(language, style: TextStyle(fontWeight: FontWeight.bold)),
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
                  child: Center(
                    child: Text('change language', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                divider(),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      item('English'),
                      SizedBox(height: 10.0),
                      item('简体中文'),
                    ],
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
                        onTap: () => {},
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

  void _refresh(String pin) async {
    Navigator.pop(context);
    Commons.process(context, () async {
      Commons.assertOK(await FlutterNfcKit.transceive('00A4040005F000000000'));
      String resp = await FlutterNfcKit.transceive('0031000000');
      Commons.assertOK(resp);
      String firmwareVersion = String.fromCharCodes(hex.decode(Commons.dropSW(resp)));
      resp = await FlutterNfcKit.transceive('0031010000');
      Commons.assertOK(resp);
      String model = String.fromCharCodes(hex.decode(Commons.dropSW(resp)));
      resp = await FlutterNfcKit.transceive('0032000000');
      Commons.assertOK(resp);
      String sn = Commons.dropSW(resp).toUpperCase();
      resp = await FlutterNfcKit.transceive('0032010000');
      Commons.assertOK(resp);
      String chipId = Commons.dropSW(resp).toUpperCase();
      resp = await FlutterNfcKit.transceive('00200000' + pin.length.toRadixString(16).padLeft(2, '0') + hex.encode(pin.codeUnits));
      if (!Commons.isOK(resp)) {
        Commons.promptPinFailureResult(context, resp);
        return;
      }
      // read configurations
      bool ledOn = false; // V1 & V2
      bool hotpOn = false; // V1 & V2
      bool ndefReadonly = false; // V1 & V2
      bool ndefEnabled = false; // V2
      bool webusbLandingEnabled = false; // V2
      bool sigTouch = false; // V1
      bool decTouch = false; // V1
      bool autTouch = false; // V1
      int cacheTime = 0; // V1
      resp = await FlutterNfcKit.transceive('0042000000');
      Commons.assertOK(resp);
      switch (CanoKey.functionSetFromFirmwareVersion(firmwareVersion)) {
        case FunctionSet.v1:
          ledOn = resp.substring(0, 2) == '01';
          hotpOn = resp.substring(2, 4) == '01';
          ndefReadonly = resp.substring(4, 6) == '01';
          sigTouch = resp.substring(6, 8) == '01';
          decTouch = resp.substring(8, 10) == '01';
          autTouch = resp.substring(10, 12) == '01';
          cacheTime = int.parse(resp.substring(12, 14), radix: 16);
          break;
        case FunctionSet.v2:
          ledOn = resp.substring(0, 2) == '01';
          hotpOn = resp.substring(2, 4) == '01';
          ndefReadonly = resp.substring(4, 6) == '01';
          ndefEnabled = resp.substring(6, 8) == '01';
          webusbLandingEnabled = resp.substring(8, 10) == '01';
          break;
      }
      setState(() {
        _key = CanoKey(model, sn, chipId, firmwareVersion, ledOn, hotpOn, ndefReadonly, ndefEnabled, webusbLandingEnabled, sigTouch, decTouch,
            autTouch, cacheTime);
        print(_key);
      });
    });
  }
}

enum FunctionSet {
  v1, // led, hotp, ndef readonly, sig/dec/aut touch, touch cache time
  v2, // led, hotp, ndef enabled/readonly, webusb landing page
}

class CanoKey {
  final String model;
  final String sn;
  final String chipId;
  final String firmwareVersion;
  final bool ledOn;
  final bool hotpOn;
  final bool ndefReadonly;
  final bool ndefEnabled;
  final bool webusbLandingEnabled;
  final bool sigTouch;
  final bool decTouch;
  final bool autTouch;
  final int touchCacheTime;

  CanoKey(this.model, this.sn, this.chipId, this.firmwareVersion, this.ledOn, this.hotpOn, this.ndefReadonly, this.ndefEnabled,
      this.webusbLandingEnabled, this.sigTouch, this.decTouch, this.autTouch, this.touchCacheTime);

  FunctionSet functionSet() {
    return functionSetFromFirmwareVersion(firmwareVersion);
  }

  static FunctionSet functionSetFromFirmwareVersion(String firmwareVersion) {
    if (firmwareVersion.compareTo('1.5.') < 0) {
      return FunctionSet.v1;
    }
    return FunctionSet.v2;
  }
}
