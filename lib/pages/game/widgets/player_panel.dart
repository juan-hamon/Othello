import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:othello/logic/player/player.dart';
import 'package:othello/pages/game/widgets/widgets.dart';
import 'package:othello/providers/providers.dart';

class PlayerPanel extends ConsumerWidget {
  const PlayerPanel({required this.player, super.key});

  final Player player;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          InGamePlayerCard(
            playerName: player.name,
            playerColor: player.color,
            playerPieces: player.getPlayablePieces(ref.read(maxPiecesProvider)),
          ),
          const Spacer(),
          Draggable(
            data: player.color,
            feedback: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: player.color,
              ),
            ),
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: player.color,
              ),
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
