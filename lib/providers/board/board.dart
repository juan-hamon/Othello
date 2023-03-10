import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This provider is used to check if the 'Enable Diagonals' checkbox
/// was pressed.
final allowDiagonalsProvider = StateProvider<bool>((ref) => false);

/// This provider is used to check if the 'Change Board Size' checkbox
/// was pressed.
final dynamicBoardSizeProvider = StateProvider<bool>((ref) => false);

/// This provider is used to store the new board dimensions if the
/// user pressed the 'Change Board Size' checkbox. It starts with the
/// value 8, because that's the default Othello board dimension.
final boardDimensionProvider = StateProvider<int>((ref) => 8);
