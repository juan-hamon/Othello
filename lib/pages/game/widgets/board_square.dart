import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:othello/logic/board/board.dart';
import 'package:othello/pages/game/widgets/widgets.dart';
import 'package:othello/providers/board/board.dart';
import 'package:othello/utils/utils.dart';

class BoardSquare extends ConsumerWidget {
  const BoardSquare({
    required this.row,
    required this.column,
    super.key,
  });

  final int row;
  final int column;

  void placePiece(Color playerColor, WidgetRef ref, BuildContext context) {
    BoardServiceNotifier boardServiceNotifier =
        ref.watch(notifierServiceProvider);
    Piece newPiece = Piece(
      color: playerColor,
      position: Pair<int, int>(row, column),
    );
    bool added = boardServiceNotifier.addPiece(newPiece);
    if (!added) {
      showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (BuildContext tcontext) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pop();
          });
          return const InvalidMovementDialog();
        },
      );
    } else {
      Color nextPlayerColor =
          (playerColor == Colors.black) ? Colors.white : Colors.black;
      boardServiceNotifier.changeTurn(nextPlayerColor);
      String? gameOverMessage =
          boardServiceNotifier.boardService.checkForGameOver(context);
      if (gameOverMessage != null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return GameOverDialog(message: gameOverMessage);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Square square = ref
        .watch(notifierServiceProvider)
        .boardService
        .board
        .squares[row][column];
    return DragTarget(
      onAccept: (Color playerColor) => placePiece(playerColor, ref, context),
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
