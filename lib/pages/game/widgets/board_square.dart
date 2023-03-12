import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:othello/logic/board/board.dart';

class BoardSquare extends ConsumerWidget {
  const BoardSquare({
    required this.square,
    required this.row,
    required this.column,
    super.key,
  });

  final Square square;
  final int row;
  final int column;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DragTarget(
      onAccept: (Color playerColor) {
        // TODO: Check if the player can place the piece in this Square.
      },
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return Container(
            color: square.color,
            padding: const EdgeInsets.all(5.0),
            child: (square.cotainsPiece())
                ? Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: square.piece!.color,
                    ),
                  )
                : const SizedBox.shrink());
      },
    );
  }
}
