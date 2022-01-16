import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:logging/logging.dart';

import '../drawer.dart';
import '../generated/l10n.dart';
import '../utils/commons.dart';

final log = Logger('ManagementTool:OATH');

class OATH extends StatefulWidget {
  static const String routeName = '/oath';

  @override
  _OATHState createState() => _OATHState();
}

class _OATHState extends State<OATH> {
  bool polled = false;
  List<OathItem> items = [];
  Version version;
  TextEditingController pinController = TextEditingController();
  TextEditingController newPinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        titleSpacing: 0.0,
        centerTitle: true,
        title: Text('TOTP / HOTP', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
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
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) =>
                    itemTile(width, Icons.pin, items[index].code, items[index].name, items[index].requireTouch, items[index].isHotp),
              ),
            ]
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

  Widget itemTile(double width, IconData icon, String code, String name, bool requireTouch, bool isHotp) {
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
                    onTap: () => calculate(name, false),
                    child: Container(
                      height: 56.0,
                      width: 56.0,
                      alignment: Alignment.center,
                      child: Icon(Icons.touch_app, size: 28.0, color: Colors.indigo[500]),
                    ),
                  ),
                if (isHotp)
                  InkWell(
                    onTap: () => calculate(name, true),
                    child: Container(
                      height: 56.0,
                      width: 56.0,
                      alignment: Alignment.center,
                      child: Icon(Icons.refresh, size: 28.0, color: Colors.indigo[500]),
                    ),
                  ),
                PopupMenuButton(
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(value: 0, child: Text('Copy to Clipboard')),
                    PopupMenuItem(value: 1, child: Text('Delete')),
                    if (isHotp) PopupMenuItem(value: 2, child: Text('Set as Default')),
                  ],
                  onSelected: (idx) {
                    if (idx == 0) { // copy
                      Clipboard.setData(ClipboardData(text: code));
                    }
                  },
                  icon: Icon(Icons.more_horiz, size: 28.0, color: Colors.indigo[500]),
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

  void refresh() async {
    Commons.process(context, () async {
      String resp = await transceive('00A4040007A0000005272101');
      Commons.assertOK(resp);
      if (resp == '9000') {
        version = Version.legacy;
      } else if (resp.substring(4, 10) == '050505') {
        version = Version.v1;
      }
      int challenge = DateTime.now().millisecondsSinceEpoch ~/ 30000;
      String challengeStr = challenge.toRadixString(16).padLeft(16, '0');
      if (version == Version.v1) {
        resp = await transceive('00A400010A7408$challengeStr');
        Uint8List data = hex.decode(Commons.dropSW(resp));
        setState(() {
          polled = true;
          items = parseV1(data);
        });
      }
    });
  }

  void calculate(String name, bool isHotp) async {
    Commons.process(context, () async {
      String resp = await transceive('00A4040007A0000005272101');
      Commons.assertOK(resp);
      if (resp == '9000') {
        version = Version.legacy;
      } else if (resp.substring(4, 10) == '050505') {
        version = Version.v1;
      }
      Uint8List nameBytes = utf8.encode(name);
      String capduData = '71' + nameBytes.length.toRadixString(16).padLeft(2, '0') + hex.encode(nameBytes);
      if (!isHotp) {
        int challenge = DateTime.now().millisecondsSinceEpoch ~/ 30000;
        String challengeStr = challenge.toRadixString(16).padLeft(16, '0');
        capduData += '7408$challengeStr';
      }
      if (version == Version.v1) {
        resp = await transceive('00A20001' + (capduData.length ~/ 2).toRadixString(16).padLeft(2, '0') + capduData);
        Uint8List data = hex.decode(Commons.dropSW(resp));
        String code = parseResponse(data.sublist(2));
        setState(() {
          items.firstWhere((e) => e.name == name).code = code;
        });
      }
    });
  }

  List<OathItem> parseV1(Uint8List data) {
    List<OathItem> result = [];
    int pos = 0;
    while (pos < data.length) {
      OathItem item = parseSingleV1(data.sublist(pos));
      pos += item._length;
      result.add(item);
    }
    return result;
  }

  OathItem parseSingleV1(Uint8List data) {
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
        item.isHotp = true;
        break;
      case 0x7C: // touch
        item.requireTouch = true;
        break;
      default:
        throw Exception('Illegal tag');
    }
    return item;
  }

  String parseResponse(Uint8List resp) {
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

class OathItem {
  String name;
  bool isHotp = false;
  bool requireTouch = false;
  String code = '';
  int _length = 0;

  OathItem(this.name);
}
