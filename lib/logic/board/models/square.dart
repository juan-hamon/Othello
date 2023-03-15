import 'package:flutter/material.dart';
import 'package:othello/logic/board/models/models.dart';

class Square {
  Color color;
  Piece? piece;

  Square({required this.color, this.piece});

  bool cotainsPiece() => piece != null;

  void setPiece(Piece piece) {
    this.piece = piece;
  }
}
