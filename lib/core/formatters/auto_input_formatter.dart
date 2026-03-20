import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AutoInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    newText = newText.replaceAll(RegExp(r'[^0-9]'), '');

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

    if (newText.length == 10) {
      DateTime? inputDate;
      final today = DateTime.now();

      try {
        inputDate = DateFormat('yyyy.MM.dd').parseStrict(newText);

        if (inputDate.isAfter(today)) {
          inputDate = today;
        }
      } catch (e) {
        inputDate = today;
      }

      newText = DateFormat('yyyy.MM.dd').format(inputDate);
    }

    return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
