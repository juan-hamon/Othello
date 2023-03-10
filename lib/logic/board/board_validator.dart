class BoardValidator {
  static String? validateBoardDimension(String? value) {
    if (value != null) {
      int? numberValue = int.tryParse(value);
      if (numberValue == null) {
        return 'Must enter a number';
      }
      if (numberValue % 2 == 1) {
        return 'Must be even';
      }
    }
    return null;
  }
}
