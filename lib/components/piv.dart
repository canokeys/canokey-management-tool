import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:logging/logging.dart';

import '../drawer.dart';
import '../generated/l10n.dart';
import '../utils/commons.dart';

final log = Logger('ManagementTool:PIV');

class PIV extends StatefulWidget {
  static const String routeName = '/piv';

  @override
  _PIVState createState() => _PIVState();
}

class _PIVState extends State<PIV> {
  bool polled = false;
  TextEditingController pinController = TextEditingController();
  TextEditingController newPinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        titleSpacing: 0.0,
        centerTitle: true,
        title: Text('PIV', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
        actions: [IconButton(icon: Icon(Icons.refresh), onPressed: refresh)],
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
                    onTap: () => showChangePinDialog(PinType.puk),
                    borderRadius: BorderRadius.circular(30.0),
                    child: Material(
                      elevation: 1.0,
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.indigo),
                        child: Text(S.of(context).pivChangePUK, style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)),
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

  void showChangePinDialog(PinType pinType) {
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
                    child: Text(S.of(context).change + (pinType == PinType.pin ? 'PIN' : 'PUK'), // Change PIN / PUK
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Text(S.of(context).changePinPrompt(6, 8), style: TextStyle(height: 1.5, fontSize: 15.0)),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
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
                      if (newPin.length < 6 || newPin.length > 8) {
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
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          changePin(pinType, pinController.text, newPinController.text);
                          pinController.text = '';
                          newPinController.text = '';
                        },
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
      Commons.assertOK(await transceive('00A4040005A000000308'));

      setState(() {
        polled = true;
      });
    });
  }

  void changePin(PinType pinType, String oldPin, String newPin) {
    Commons.process(context, () async {
      Commons.assertOK(await transceive('00A4040005A000000308'));
      String resp = await transceive('002400' +
          (pinType == PinType.pin ? '80' : '81') +
          '10' +
          hex.encode(oldPin.codeUnits).padRight(16, 'F') +
          hex.encode(newPin.codeUnits).padRight(16, 'F'));
      if (resp == '9000') {
        Navigator.pop(context);
        Commons.promptSuccess(S.of(context).pinChanged);
      } else {
        Commons.promptPinFailureResult(context, resp);
      }
    });
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
}

enum PinType { pin, puk }
