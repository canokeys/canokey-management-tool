import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../generated/l10n.dart';

class Commons {
  static String dropSW(String rapdu) {
    return rapdu.substring(0, rapdu.length - 4);
  }

  static bool isOK(String rapdu) {
    return rapdu.endsWith('9000');
  }

  static void assertOK(String rapdu) {
    if (!isOK(rapdu)) {
      throw Exception('SW is not ok');
    }
  }

  static Future<void> process(BuildContext context, Function f) async {
    try {
      await FlutterNfcKit.poll();
      await f();
    } on PlatformException catch (e) {
      if (e.message == 'NotFoundError: No device selected.') {
        promptFailure(S.of(context).pollCanceled);
      } else if (e.message == 'NetworkError: A transfer error has occurred.') {
        promptFailure(S.of(context).networkError);
      } else {
        promptFailure(e.message ?? 'Unknown error');
      }
    } finally {
      FlutterNfcKit.finish(closeWebUSB: false);
    }
  }

  static void promptPinFailureResult(BuildContext context, String resp) {
    if (resp == '6983') {
      promptFailure(S.of(context).appletLocked);
    } else if (resp == '6982') {
      promptFailure(S.of(context).pinIncorrect);
    } else if (resp.toUpperCase().startsWith('63C')) {
      String retries = resp[resp.length - 1];
      promptFailure(S.of(context).pinRetries(retries));
    } else if (resp == '6700') {
      promptFailure(S.of(context).pinLength);
    } else {
      promptFailure('Unknown response');
    }
  }

  static void promptSuccess(String content) {
    Fluttertoast.showToast(
        msg: content,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
        webPosition: 'center',
        webBgColor: '#4CAF50');
  }

  static void promptFailure(String content) {
    Fluttertoast.showToast(
        msg: content,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
        webPosition: 'center',
        webBgColor: '#F44336');
  }
}
