import 'dart:typed_data';

class APDU {
  static Uint8List dropSW(Uint8List rapdu) {
    return rapdu.sublist(0, rapdu.length - 2);
  }
}
