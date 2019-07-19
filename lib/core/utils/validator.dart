class Validator {
  static bool stringMatchesRange(String string, int minLength, int maxLength) {
    if (minLength < 0 || maxLength < 0)
      throw Exception("minLength and maxLength must be greater than zero");
    if (minLength > maxLength)
      throw Exception("minLength must be less than or equal to maxLength");
    return string.length >= minLength && string.length <= maxLength;
  }

  static String stringLengthValidator(
      String value, fieldName, minLength, maxLength) {
    if (!stringMatchesRange(value, minLength, maxLength))
      return 'fieldName should be $minLength to $maxLength characters';
    return null;
  }

  static String stringNumberSizeValidator(
      String value, fieldName, minSize, maxSize) {
    var numValue = int.tryParse(value);
    if (numValue == null) {
      return "$fieldName must be between $minSize and $maxSize";
    }
    return null;
  }
}
