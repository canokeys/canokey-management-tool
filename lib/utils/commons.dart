import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

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

  static void process(BuildContext context, Function f) async {
    try {
      await FlutterNfcKit.poll();
      await f();
    } on PlatformException catch (e) {
      if (e.message == 'NotFoundError: No device selected.') {
        Flushbar(backgroundColor: Colors.red, message: S.of(context).pollCanceled, duration: Duration(seconds: 3)).show(context);
      } else if (e.message == 'NetworkError: A transfer error has occurred.') {
        Flushbar(backgroundColor: Colors.red, message: S.of(context).networkError, duration: Duration(seconds: 3)).show(context);
      } else {
        Flushbar(backgroundColor: Colors.red, message: e.message, duration: Duration(seconds: 3)).show(context);
      }
    } finally {
      FlutterNfcKit.finish();
    }
  }

  static void promptPinFailureResult(BuildContext context, String resp) {
    if (resp == '6983') {
      Flushbar(backgroundColor: Colors.red, message: S.of(context).appletLocked, duration: Duration(seconds: 3)).show(context);
    } else if (resp == '6982') {
      Flushbar(backgroundColor: Colors.red, message: S.of(context).pinIncorrect, duration: Duration(seconds: 3)).show(context);
    } else if (resp.toUpperCase().startsWith('63C')) {
      String retries = resp[resp.length - 1];
      Flushbar(backgroundColor: Colors.red, message: S.of(context).pinRetries(retries), duration: Duration(seconds: 3)).show(context);
    } else if (resp == '6700') {
      Flushbar(backgroundColor: Colors.red, message: S.of(context).pinLength, duration: Duration(seconds: 3)).show(context);
    } else {
      Flushbar(backgroundColor: Colors.red, message: 'Unknown response', duration: Duration(seconds: 3)).show(context);
    }
  }
}
