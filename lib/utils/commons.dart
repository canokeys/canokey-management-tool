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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, behavior: SnackBarBehavior.floating, content: Text(S.of(context).pollCanceled)),
        );
      } else if (e.message == 'NetworkError: A transfer error has occurred.') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, behavior: SnackBarBehavior.floating, content: Text(S.of(context).networkError)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, behavior: SnackBarBehavior.floating, content: Text(e.message)),
        );
      }
    } finally {
      FlutterNfcKit.finish();
    }
  }

  static void promptPinFailureResult(BuildContext context, String resp) {
    if (resp == '6983') {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, behavior: SnackBarBehavior.floating, content: Text(S.of(context).appletLocked)),
      );
    } else if (resp == '6982') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, behavior: SnackBarBehavior.floating, content: Text(S.of(context).pinIncorrect)),
      );
    } else if (resp.startsWith('63C')) {
      String retries = resp[resp.length - 1];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, behavior: SnackBarBehavior.floating, content: Text(S.of(context).pinRetries(retries))),
      );
    } else if (resp == '6700') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, behavior: SnackBarBehavior.floating, content: Text(S.of(context).pinLength)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, behavior: SnackBarBehavior.floating, content: Text('Unknown response')),
      );
    }
  }
}
