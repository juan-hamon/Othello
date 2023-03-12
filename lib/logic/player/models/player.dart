import 'package:flutter/material.dart';
import 'package:othello/logic/board/models/models.dart';

class Player {
  int id;
  String name;
  Color color;
  List<Piece> placedPieces;

  Player({
    required this.id,
    required this.name,
    required this.color,
    this.placedPieces = const [],
  });

  int getPlayablePieces(int maxPieces) {
    return maxPieces - placedPieces.length;
  }

  void addPiece(Piece toAdd) {
    placedPieces.add(toAdd);
  }

  void addPieces(List<Piece> toAdd) {
    placedPieces.addAll(toAdd);
  }

  void removePlacedPieces(List<Piece> toRemove) {
    for (Piece piece in toRemove) {
      placedPieces.remove(piece);
    }
  }

  @override
  bool operator ==(Object other) {
    return other is Player &&
        id == other.id &&
        name == other.name &&
        color == other.color;
  }

  @override
  int get hashCode => id;
}
