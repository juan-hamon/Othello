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
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: playerColor,
                    ),
                  ),
                  child: Container(
                    height: 120,
                    width: 120,
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
