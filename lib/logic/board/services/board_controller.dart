import 'package:flutter/material.dart';
import 'package:othello/logic/board/board.dart';
import 'package:othello/logic/player/models/player.dart';
import 'package:othello/utils/direction.dart';

class BoardController extends BoardService {
  BoardController({
    required super.board,
    required super.currentPlayer,
  });

  @override
  bool addPiece(Piece toAdd) {
    // TODO: implement addPiece
    throw UnimplementedError();
  }

  @override
  void addPlayer(Player toAdd) {
    // TODO: implement addPlayer
  }

  @override
  void changeCurrentPlayer(Player nextPlayer) {
    // TODO: implement changeCurrentPlayer
  }

  @override
  void changeTurn(Color nextPlayerColor) {
    // TODO: implement changeTurn
    throw UnimplementedError();
  }

  @override
  void checkForGameOver() {
    // TODO: implement checkForGameOver
  }

  @override
  void convertPieces(List<Piece> piecesToConvert, Color color) {
    // TODO: implement convertPieces
  }

  @override
  bool hasPossibleMovements() {
    // TODO: implement hasPossibleMovements
    throw UnimplementedError();
  }

  @override
  List<Piece> obtainAdjacentPieces(Piece piece) {
    // TODO: implement obtainAdjacentPieces
    throw UnimplementedError();
  }

  @override
  Direction obtainDirection(Piece begin, Piece end) {
    // TODO: implement obtainDirection
    throw UnimplementedError();
  }

  @override
  List<Piece> obtainPiecesToConvert(Piece initialPiece, Direction direction) {
    // TODO: implement obtainPiecesToConvert
    throw UnimplementedError();
  }

  @override
  void restartGame() {
    // TODO: implement restartGame
    throw UnimplementedError();
  }

  @override
  void startGame() {
    // TODO: implement startGame
  }
}
