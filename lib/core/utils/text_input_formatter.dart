import 'package:flutter/services.dart';

// base on chatGPT, this is formatter for TextFormField,
// call this class like this
// inputFormatters: [
//   FilteringTextInputFormatter.digitsOnly,
//   ThousandsFormatter(),
//   PhoneNumberFormatter(),
// ],

//https://chat.openai.com/c/cc3e65b4-c67b-434c-86be-9e82b89e7cb9
class ThousandsTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;

    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();

    // Handling negative sign if present
    if (newValue.text[0] == '-') {
      newText.write('-');
      usedSubstringIndex++;
    }

    for (int i = usedSubstringIndex; i < newTextLength; i++) {
      if (i > usedSubstringIndex &&
          (newTextLength - i + usedSubstringIndex) % 3 == 0) {
        newText.write('.');
        if (selectionIndex > i) {
          selectionIndex++;
        }
      }
      newText.write(newValue.text[i]);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class PhoneNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;

    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();

    for (int i = 0; i < newTextLength; i++) {
      if (i == 4 || i == 8 || i == 12) {
        newText.write('-');
        if (selectionIndex > i) {
          selectionIndex++;
        }
      }
      newText.write(newValue.text[usedSubstringIndex]);
      usedSubstringIndex++;
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class SingleDotInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Menghitung jumlah titik dalam teks baru
    int dotCount = newValue.text.split('.').length - 1;

    // Jika jumlah titik lebih dari satu, hilangkan yang terakhir
    if (dotCount > 1) {
      String newText =
          newValue.text.substring(0, newValue.text.lastIndexOf('.'));
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    // Jika jumlah titik satu atau kurang, izinkan perubahan
    return newValue;
  }
}

// call this function, or just use regex
// FilteringTextInputFormatter.deny(RegExp(r'^\s')),
class NoLeadingSpacesInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      // Prevent leading spaces
      return oldValue;
    }
    return newValue;
  }
}
