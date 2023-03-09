import 'package:flutter/material.dart';

class PlayerValidator {
  /// Checks if a given name is a valid input.
  static String? isValidName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  static bool areNamesEqual({required String name1, required String name2}) {
    return name1 == name2;
  }

  static bool areColorsEqual({required Color color1, required Color color2}) {
    return color1 == color2;
  }
}
