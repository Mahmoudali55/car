import 'package:flutter/services.dart';

class CardExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    newText = newText.replaceAll(RegExp(r'[^0-9/]'), '');

    if (oldValue.text.endsWith('/') && newText.length < oldValue.text.length) {
      newText = newText.substring(0, newText.length - 1);
    } else if (newText.length == 2 && !newText.contains('/')) {
      newText += '/';
    } else if (newText.length > 2 && !newText.contains('/')) {
      newText = '${newText.substring(0, 2)}/${newText.substring(2)}';
    }

    if (newText.length > 5) {
      newText = newText.substring(0, 5);
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
