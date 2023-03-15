import 'package:flutter/material.dart';
import 'package:othello/utils/utils.dart';

class Piece {
  Color color;
  Pair<int, int> position;

  Piece({required this.color, required this.position});

  setPosition(Pair<int, int> nPosition) {
    position = nPosition;
  }

  setColor(Color nColor) {
    color = nColor;
  }
}
