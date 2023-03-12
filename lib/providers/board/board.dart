import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:othello/logic/board/board.dart';

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

/// This provider returns the maximum number of pices that each
/// player can have, which is half of the board squares. For example,
/// with a board with 64 squares, each player can have a maximum of
/// 32 pieces.
final maxPiecesProvider = Provider<int>((ref) {
  int boardDimension = pow(ref.watch(boardDimensionProvider), 2).toInt();
  return boardDimension ~/ 2;
});

/// This provider is used to expose the [Board] instance that is used
/// for the game.
final boardProvider = Provider<Board>((ref) {
  int boardDimension = ref.watch(boardDimensionProvider);
  bool allowDiagonals = ref.watch(allowDiagonalsProvider);
  return Board(
    columns: boardDimension,
    rows: boardDimension,
    allowDiagonals: allowDiagonals,
  );
});

// TODO: Add the BoardService provider.
