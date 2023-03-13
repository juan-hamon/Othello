import 'package:flutter/material.dart';
import 'package:othello/logic/board/board.dart';
import 'package:othello/logic/player/player.dart';
import 'package:othello/utils/utils.dart';

abstract class BoardService {
  final Board board;
  Player currentPlayer;
  final Map<Color, Player> players = {};

  BoardService({
    required this.board,
    required this.currentPlayer,
  });

  bool addPiece(Piece toAdd);
  void addPlayer(Player toAdd);
  void changeCurrentPlayer(Player nextPlayer);
  void changeTurn(Color nextPlayerColor);
  void checkForGameOver();
  bool checkForPath(Piece initialPiece, Direction direction);
  void convertPieces(List<Piece> piecesToConvert, Color color);
  bool hasPossibleMovements();
  List<Piece> obtainAdjacentPieces(Piece piece);
  Direction obtainDirection(Piece begin, Piece end);
  List<Piece> obtainPiecesToConvert(Piece initialPiece, Direction direction);
}
