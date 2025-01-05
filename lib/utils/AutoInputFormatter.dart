import 'dart:math';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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

    // // Check if the formatted text represents a valid date
    // DateTime? inputDate;
    // try {
    //   inputDate = DateFormat('yyyy.MM.dd').parseStrict(newText);
    // } catch (e) {
    //   inputDate = null;
    // }

    // // Get today's date
    // final today = DateTime.now();

    // // If the input date is in the future, set it to today
    // if (inputDate != null && inputDate.isAfter(today)) {
    //   newText = DateFormat('yyyy.MM.dd').format(today);
    // }

    // Only validate and adjust the date if the input length matches 'yyyy.MM.dd'
    if (newText.length == 10) {
      DateTime? inputDate;
      final today = DateTime.now();

      try {
        inputDate = DateFormat('yyyy.MM.dd').parseStrict(newText);

        // If the date is in the future, replace it with today's date
        if (inputDate.isAfter(today)) {
          inputDate = today;
        }
      } catch (e) {
        // If parsing fails, replace with today's date
        inputDate = today;
      }

      // Format the final date as yyyy.MM.dd
      newText = DateFormat('yyyy.MM.dd').format(inputDate);
    }

    // Ensure the cursor remains at the end of the text
    return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
