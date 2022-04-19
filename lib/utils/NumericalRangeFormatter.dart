import 'package:flutter/services.dart';

class NumericalRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumericalRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text == '') return newValue;
    int? value = int.tryParse(newValue.text);
    if (value == null) return oldValue;
    if (value < min) return TextEditingValue().copyWith(text: min.toString());
    return value > max ? oldValue : newValue;
  }
}
