import 'package:another_flushbar/flushbar.dart';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:logging/logging.dart';

import '../drawer.dart';
import '../generated/l10n.dart';
import '../utils/NumericalRangeFormatter.dart';
import '../utils/commons.dart';

final log = Logger('ManagementTool:Settings');

class Settings extends StatefulWidget {
  static const String routeName = '/settings';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController pinController = TextEditingController();
  TextEditingController newPinController = TextEditingController();
  TextEditingController cacheTimeController = TextEditingController();
  CanoKey key;
  String pin;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        titleSpacing: 0.0,
        centerTitle: true,
        title: Text(S.of(context).settings, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
        actions: [IconButton(icon: Icon(Icons.refresh), onPressed: showInputPinDialog)],
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            if (key == null) ...[
              SizedBox(height: 30.0),
              Center(
                child: Text(S.of(context).pollCanoKey, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 30.0),
            ] else ...[
              Text(S.of(context).settingsInfo, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 15.0),
              itemTile(width, Icons.mode, S.of(context).settingsModel, key.model),
              itemTile(width, Icons.info, S.of(context).settingsFirmwareVersion, key.firmwareVersion),
              itemTile(width, Icons.vpn_key, S.of(context).settingsSN, key.sn),
              itemTile(width, Icons.memory, S.of(context).settingsChipId, key.chipId),
              SizedBox(height: 25.0),
              Text(S.of(context).settings, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 15.0),
              if (key.functionSet().contains(Func.led))
                itemTile(width, Icons.light_mode, 'LED', key.ledOn ? S.of(context).on : S.of(context).off,
                    () => showChangeSwitchDialog('LED', Func.led, key.ledOn)),
              if (key.functionSet().contains(Func.hotp))
                itemTile(width, Icons.keyboard_alt_outlined, S.of(context).settingsHotp, key.hotpOn ? S.of(context).on : S.of(context).off,
                    () => showChangeSwitchDialog(S.of(context).settingsHotp, Func.hotp, key.hotpOn)),
              if (key.functionSet().contains(Func.webusbLandingPage))
                itemTile(width, Icons.web, S.of(context).settingsWebUSB, key.webusbLandingEnabled ? S.of(context).on : S.of(context).off,
                    () => showChangeSwitchDialog(S.of(context).settingsWebUSB, Func.webusbLandingPage, key.webusbLandingEnabled)),
              if (key.functionSet().contains(Func.ndefEnabled))
                itemTile(width, Icons.nfc, S.of(context).settingsNDEF, key.ndefEnabled ? S.of(context).on : S.of(context).off,
                    () => showChangeSwitchDialog(S.of(context).settingsNDEF, Func.ndefEnabled, key.ndefEnabled)),
              if (key.functionSet().contains(Func.ndefReadonly))
                itemTile(width, Icons.brush, S.of(context).settingsNDEFReadonly, key.ndefReadonly ? S.of(context).on : S.of(context).off,
                    () => showChangeSwitchDialog(S.of(context).settingsNDEFReadonly, Func.ndefReadonly, key.ndefReadonly)),
              if (key.functionSet().contains(Func.sigTouch)) ...[
                // OpenPGP options work together
                SizedBox(height: 25.0),
                Text('OpenPGP ' + S.of(context).openpgpUIF, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 15.0),
                itemTile(width, Icons.brush, S.of(context).openpgpSignature, key.sigTouch ? S.of(context).on : S.of(context).off,
                    () => showChangeSwitchDialog(S.of(context).openpgpSignature, Func.led, key.ledOn)),
                itemTile(width, Icons.brush, S.of(context).openpgpEncryption, key.decTouch ? S.of(context).on : S.of(context).off,
                    () => showChangeSwitchDialog(S.of(context).openpgpEncryption, Func.led, key.ledOn)),
                itemTile(width, Icons.brush, S.of(context).openpgpAuthentication, key.autTouch ? S.of(context).on : S.of(context).off,
                    () => showChangeSwitchDialog(S.of(context).openpgpAuthentication, Func.led, key.ledOn)),
                itemTile(width, Icons.brush, S.of(context).openpgpUifCacheTime, key.touchCacheTime.toString(), showChangeCacheTimeDialog),
              ]
            ],
            Text(S.of(context).actions, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 15.0),
            Wrap(
              spacing: 15.0,
              runSpacing: 15.0,
              children: [
                if (key != null) ...[
                  InkWell(
                    onTap: showChangePinDialog,
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
                    onTap: () => showResetAppletDialog(Applet.OpenPGP),
                    borderRadius: BorderRadius.circular(30.0),
                    child: Material(
                      elevation: 1.0,
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.red),
                        child: Text(S.of(context).settingsResetOpenPGP,
                            style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => showResetAppletDialog(Applet.PIV),
                    borderRadius: BorderRadius.circular(30.0),
                    child: Material(
                      elevation: 1.0,
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.red),
                        child:
                            Text(S.of(context).settingsResetPIV, style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => showResetAppletDialog(Applet.OATH),
                    borderRadius: BorderRadius.circular(30.0),
                    child: Material(
                      elevation: 1.0,
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.red),
                        child:
                            Text(S.of(context).settingsResetOATH, style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => showResetAppletDialog(Applet.NDEF),
                    borderRadius: BorderRadius.circular(30.0),
                    child: Material(
                      elevation: 1.0,
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.red),
                        child:
                            Text(S.of(context).settingsResetNDEF, style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
                InkWell(
                  onTap: showResetDialog,
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
            itemTile(width, Icons.language, S.of(context).settingsLanguage, '简体中文', () => showChangeLanguageDialog('简体中文')),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    pinController.dispose();
    newPinController.dispose();
    cacheTimeController.dispose();
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

  void showChangeSwitchDialog(String title, Func function, bool currentStatus) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          item(bool status) {
            return InkWell(
              onTap: () => setState(() => currentStatus = status),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (currentStatus == status) Icon(Icons.check, size: 28.0, color: Colors.indigo[500]) else SizedBox(width: 28.0, height: 28.0),
                  SizedBox(width: 20.0),
                  Text(status ? S.of(context).on : S.of(context).off, style: TextStyle(fontWeight: FontWeight.bold)),
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
                    child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                Divider(color: Colors.black),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      item(true),
                      SizedBox(height: 10.0),
                      item(false),
                    ],
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
                        onTap: () => changeSwitch(function, currentStatus, pin),
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

  void showInputPinDialog() {
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
                  child: Center(
                    child: Text(S.of(context).settingsInputPin, style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                Divider(color: Colors.black),
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Text(S.of(context).settingsInputPinPrompt, style: TextStyle(height: 1.5, fontSize: 15.0)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: pinController,
                    obscureText: tapPin,
                    autofocus: true,
                    onSubmitted: (String pin) {
                      if (pin.isEmpty) return;
                      refresh(pin);
                      Navigator.pop(context);
                    },
                    decoration: InputDecoration(
                      labelText: 'PIN',
                      hintText: 'PIN',
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
                Divider(color: Colors.black),
                Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.only(left: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          refresh(pinController.text);
                          Navigator.pop(context);
                        },
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

  void showResetDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
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
                    Text(S.of(context).settingsResetAll),
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
                          onTap: reset,
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

  void showResetAppletDialog(Applet applet) {
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(S.of(context).warning, style: TextStyle(fontWeight: FontWeight.bold)),
                      Divider(color: Colors.black),
                      SizedBox(height: 10.0),
                      Text(S.of(context).settingsResetApplet(applet.name)),
                      SizedBox(height: 10.0),
                      Container(
                        padding: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
                        child: TextField(
                          controller: pinController,
                          obscureText: tapPin,
                          autofocus: true,
                          onSubmitted: (String pin) {
                            if (pin.isEmpty) return;
                            resetApplet(applet, pin);
                            Navigator.pop(context);
                          },
                          decoration: InputDecoration(
                            labelText: 'PIN',
                            hintText: 'PIN',
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
                      Divider(color: Colors.black),
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
                            onTap: () => resetApplet(applet, pinController.text),
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
        });
      },
    );
  }

  void showChangePinDialog() {
    bool tapPin = true;
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
                    child: Text(S.of(context).change + ' PIN', // Change PIN / Change Admin PIN
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Text(S.of(context).changePinPrompt(6), style: TextStyle(height: 1.5, fontSize: 15.0)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: pinController,
                    obscureText: tapPin,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: S.of(context).oldPin,
                      hintText: S.of(context).oldPin,
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
                  padding: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: newPinController,
                    obscureText: tapNewPin,
                    onChanged: (newPin) => setState(() {
                      if (newPin.length < 6 || newPin.length > 64) {
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
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.only(left: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => changePin(pinController.text, newPinController.text),
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
                  child: Center(child: Text(S.of(context).openpgpChangeTouchCacheTime, style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                divider(),
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: cacheTimeController,
                    keyboardType: TextInputType.number,
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
                    decoration: InputDecoration(
                      labelText: 'PIN',
                      hintText: 'PIN',
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
                        onTap: () => changeTouchCacheTime(int.parse(cacheTimeController.text), pin),
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

  void showChangeLanguageDialog(String currentLanguage) {
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
                SizedBox(height: 10.0),
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
                SizedBox(height: 10.0),
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

  void refresh(String pin) async {
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
        this.pin = null;
        Commons.promptPinFailureResult(context, resp);
        return;
      }
      this.pin = pin;
      // read configurations
      bool ledOn = false;
      bool hotpOn = false;
      bool ndefReadonly = false;
      bool ndefEnabled = false;
      bool webusbLandingEnabled = false;
      bool sigTouch = false;
      bool decTouch = false;
      bool autTouch = false;
      int cacheTime = 0;
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
        key = CanoKey(model, sn, chipId, firmwareVersion, ledOn, hotpOn, ndefReadonly, ndefEnabled, webusbLandingEnabled, sigTouch, decTouch,
            autTouch, cacheTime);
      });
    });
  }

  void changePin(String oldPin, String newPin) async {
    Commons.process(context, () async {
      Commons.assertOK(await FlutterNfcKit.transceive('00A4040005F000000000'));
      if (!await verifyPin(oldPin)) return;
      Navigator.pop(context);
      Commons.assertOK(await FlutterNfcKit.transceive('00210000' + newPin.length.toRadixString(16).padLeft(2, '0') + hex.encode(newPin.codeUnits)));
      Flushbar(backgroundColor: Colors.green, message: S.of(context).pinChanged, duration: Duration(seconds: 3)).show(context);
      pin = null;
    });
  }

  void changeTouchCacheTime(int cacheTime, String pin) async {
    Commons.process(context, () async {
      Commons.assertOK(await FlutterNfcKit.transceive('00A4040005F000000000'));
      if (!await verifyPin(pin)) return;
      Navigator.pop(context);
      Commons.assertOK(await FlutterNfcKit.transceive('000903' + cacheTime.toRadixString(16).padLeft(2, '0')));
      Flushbar(backgroundColor: Colors.green, message: S.of(context).openpgpUifCacheTimeChanged, duration: Duration(seconds: 3)).show(context);
      refresh(pin);
    });
  }

  Future<bool> verifyPin(String pin) async {
    String resp = await FlutterNfcKit.transceive('00200000' + pin.length.toRadixString(16).padLeft(2, '0') + hex.encode(pin.codeUnits));
    if (Commons.isOK(resp)) return true;
    Commons.promptPinFailureResult(context, resp);
    return false;
  }

  void changeSwitch(Func function, bool newStatus, String pin) async {
    Commons.process(context, () async {
      Commons.assertOK(await FlutterNfcKit.transceive('00A4040005F000000000'));
      if (!await verifyPin(pin)) return;
      Navigator.pop(context);
      Commons.assertOK(await FlutterNfcKit.transceive(changeSwitchAPDUs[function][newStatus]));
      Flushbar(backgroundColor: Colors.green, message: S.of(context).successfullyChanged, duration: Duration(seconds: 3)).show(context);
      refresh(pin);
    });
  }

  void resetApplet(Applet applet, String pin) async {
    Commons.process(context, () async {
      Commons.assertOK(await FlutterNfcKit.transceive('00A4040005F000000000'));
      if (!await verifyPin(pin)) return;
      Navigator.pop(context);
      Commons.assertOK(await FlutterNfcKit.transceive(resetAppletAPDUs[applet]));
      Flushbar(backgroundColor: Colors.green, message: S.of(context).settingsResetSuccess, duration: Duration(seconds: 3)).show(context);
      refresh(pin);
    });
  }

  void reset() async {
    Commons.process(context, () async {
      Commons.assertOK(await FlutterNfcKit.transceive('00A4040005F000000000'));
      // TODO: add loading animation
      String resp = await FlutterNfcKit.transceive('00500000055245534554');
      if (resp == '9000') {
        Navigator.pop(context);
        Flushbar(backgroundColor: Colors.green, message: S.of(context).settingsResetSuccess, duration: Duration(seconds: 3)).show(context);
      } else if (resp == '6985') {
        Flushbar(backgroundColor: Colors.red, message: S.of(context).settingsResetConditionNotSatisfying, duration: Duration(seconds: 3))
            .show(context);
      } else if (resp == '6982') {
        Flushbar(backgroundColor: Colors.red, message: S.of(context).settingsResetPresenceTestFailed, duration: Duration(seconds: 3)).show(context);
      } else {
        Flushbar(backgroundColor: Colors.red, message: 'Unknown error', duration: Duration(seconds: 3)).show(context);
      }
    });
  }

  Map changeSwitchAPDUs = {
    Func.led: {true: '00400101', false: '00400100'},
    Func.hotp: {true: '00400301', false: '00400300'},
    Func.ndefEnabled: {true: '00400401', false: '00400400'},
    Func.ndefReadonly: {true: '00080100', false: '00080000'},
    Func.webusbLandingPage: {true: '00400501', false: '00400500'},
    Func.sigTouch: {true: '00090001', false: '00090000'},
    Func.decTouch: {true: '00090101', false: '00090100'},
    Func.autTouch: {true: '00090201', false: '00090200'},
  };

  Map resetAppletAPDUs = {
    Applet.OpenPGP: '00030000',
    Applet.PIV: '00040000',
    Applet.OATH: '00050000',
    Applet.NDEF: '00070000',
  };
}

enum Applet { OpenPGP, PIV, WebAuthn, OATH, NDEF }

enum Func { led, hotp, ndefEnabled, ndefReadonly, webusbLandingPage, sigTouch, decTouch, autTouch, touchCacheTime }

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

  Set<Func> functionSet() {
    if (firmwareVersion.compareTo('1.5.') < 0) {
      return {Func.led, Func.hotp, Func.ndefReadonly, Func.sigTouch, Func.decTouch, Func.autTouch, Func.touchCacheTime};
    }
    return {Func.led, Func.hotp, Func.webusbLandingPage, Func.ndefEnabled, Func.ndefReadonly};
  }

  static FunctionSet functionSetFromFirmwareVersion(String firmwareVersion) {
    if (firmwareVersion.compareTo('1.5.') < 0) {
      return FunctionSet.v1;
    }
    return FunctionSet.v2;
  }
}
