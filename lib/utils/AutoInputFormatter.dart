import 'dart:math';
import 'package:flutter/services.dart';

class AutoInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // Remove all non-digit characters
    newText = newText.replaceAll(RegExp(r'[^0-9]'), '');

    // Apply the date format (yyyy.MM.dd)
    if (newText.length > 4 && newText.length <= 6) {
      newText =
          newText.substring(0, 4) + '.' + newText.substring(4, newText.length);
    } else if (newText.length > 6) {
      newText = newText.substring(0, 4) +
          '.' +
          newText.substring(4, 6) +
          '.' +
          newText.substring(6, min(8, newText.length));
    }

    // Ensure the cursor remains at the end of the text
    return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
