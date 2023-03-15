import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:othello/logic/board/board.dart';
import 'package:othello/logic/player/player.dart';
import 'package:othello/providers/providers.dart';

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

/// This provider is used to expose the [BoardService] instances that
/// is used to play the game.
final boardServiceProvider = Provider<BoardService>((ref) {
  Board board = ref.watch(boardProvider);
  // This prevents the app to fail when the game is over, because we dispose
  // all the providers and it will try to find the element with key Colors.black,
  // which does not exist.
  Player currentPlayer = (ref.watch(playersProvider)[Colors.black] == null)
      ? Player(id: 1, name: "", color: Colors.black)
      : ref.watch(playersProvider)[Colors.black]!;
  Player secondPlayer = (ref.watch(playersProvider)[Colors.white] == null)
      ? Player(id: 2, name: "", color: Colors.white)
      : ref.watch(playersProvider)[Colors.white]!;
  BoardService controller = BoardController(
    board: board,
    currentPlayer: currentPlayer,
  );
  controller.addPlayer(currentPlayer);
  controller.addPlayer(secondPlayer);
  return controller;
});

/// This provider is used to manage the UI changes for each
/// piece that is placed on the board and the change of turns
/// between players.
final notifierServiceProvider = ChangeNotifierProvider((ref) {
  BoardService boardService = ref.watch(boardServiceProvider);
  return BoardServiceNotifier(boardService);
});

/// This is the class used to notify the listeners that the UI
/// must change because a piece was placed on the board, which
/// leads to a change of turn.
class BoardServiceNotifier extends ChangeNotifier {
  BoardServiceNotifier(this.boardService);
  final BoardService boardService;

  bool addPiece(Piece toAdd) {
    bool result = boardService.addPiece(toAdd);
    notifyListeners();
    return result;
  }

  void changeTurn(Color nextPlayerColor) {
    boardService.changeTurn(nextPlayerColor);
    notifyListeners();
  }
}
