class CardValidation {
  static String stripDigits(String value) =>
      value.replaceAll(RegExp(r'\D'), '');

  static String formatVisaInput(String value) {
    final digits = stripDigits(value);
    final limited = digits.length > 16 ? digits.substring(0, 16) : digits;
    final buffer = StringBuffer();
    for (var i = 0; i < limited.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write('-');
      buffer.write(limited[i]);
    }
    return buffer.toString();
  }

  static String? validateVisa(String value) {
    final digits = stripDigits(value);
    if (digits.length != 16) {
      return 'Visa card number must be 16 digits';
    }
    if (!digits.startsWith('4')) {
      return 'Visa card number must start with 4';
    }
    return null;
  }

  static String? validateNationalCard(String value) {
    final digits = stripDigits(value);
    if (digits.length != 14) {
      return 'National Card number must be exactly 14 digits';
    }
    return null;
  }

  static String? validateForCardType(String value, String cardTypeName) {
    final lower = cardTypeName.toLowerCase();
    if (lower == 'visa') return validateVisa(value);
    if (lower == 'national card') return validateNationalCard(value);
    if (value.isEmpty) return 'Card number is required';
    if (value.length > 30) return 'Card number must be at most 30 characters';
    return null;
  }

  static String normalizeForSubmit(String value, String cardTypeName) {
    final lower = cardTypeName.toLowerCase();
    if (lower == 'visa' || lower == 'national card') {
      return stripDigits(value);
    }
    return value;
  }
}
