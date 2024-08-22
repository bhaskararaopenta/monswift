import 'package:flutter/services.dart';

  int formatEditUpdate(TextEditingValue oldValue,
    TextEditingValue newValue) {
  // Ensure the new value starts with a non-zero digit
  if (newValue.text.isEmpty || newValue.text.startsWith('0')) {
    // If empty or starts with '0', return the old value
    return 11;
  } else {
    // Otherwise, allow the change
    return 10;
  }
}
class DynamicLengthLimitingTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    int maxLength = newValue.text.startsWith('0') ? 11 : 10;
    if (newValue.text.length > maxLength) {
      return oldValue;
    }
    return newValue;
  }
}

class DynamicLengthLimitingTextInputFormatterForCountry extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    int maxLength = newValue.text.startsWith('0') ? 10 : 9;
    if (newValue.text.length > maxLength) {
      return oldValue;
    }
    return newValue;
  }
}