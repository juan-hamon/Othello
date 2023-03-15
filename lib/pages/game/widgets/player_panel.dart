import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:othello/logic/board/board.dart';
import 'package:othello/pages/game/widgets/widgets.dart';
import 'package:othello/providers/providers.dart';

class PlayerPanel extends ConsumerWidget {
  const PlayerPanel({required this.playerColor, super.key});

  final Color playerColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BoardService boardService = ref.watch(notifierServiceProvider).boardService;
    Size appSize = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          InGamePlayerCard(
            player: boardService.players[playerColor]!,
          ),
          const Spacer(),
          (boardService.currentPlayer == boardService.players[playerColor]!)
              ? Draggable(
                  data: playerColor,
                  feedback: Container(
                    height: (appSize.height * 0.45),
                    width: (appSize.width * 0.45) / boardService.board.columns,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: playerColor,
                    ),
                  ),
                  child: Container(
                    height: (appSize.height * 0.495),
                    width: (appSize.width * 0.495) / boardService.board.columns,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: playerColor,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
