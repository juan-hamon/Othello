class PlayerValidator {
  /// Checks if a given name is a valid input.
  static String? isValidName({required String? name}) {
    if (name == null || name.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }
}
