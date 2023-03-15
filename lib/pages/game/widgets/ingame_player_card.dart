import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:othello/logic/player/player.dart';
import 'package:othello/pages/game/widgets/widgets.dart';
import 'package:othello/providers/providers.dart';

class InGamePlayerCard extends ConsumerWidget {
  const InGamePlayerCard({
    required this.player,
    super.key,
  });

  final Player player;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Player currentPlayer = ref.watch(boardServiceProvider).currentPlayer;
    return Card(
      elevation: 10.0,
      shadowColor: Theme.of(context).shadowColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: player == currentPlayer ? Colors.amber : Colors.transparent,
            width: 2.5,
          ),
        ),
        constraints: const BoxConstraints(
          maxWidth: 250,
          maxHeight: 200,
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              player.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ListTile(
              leading: Container(
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: player.color,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.flag,
                ),
                color: Colors.red,
                onPressed: player == currentPlayer
                    ? () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return GiveUpDialog(player: player);
                          },
                        );
                      }
                    : null,
              ),
              title: Text(
                "x${player.getPlayablePieces(ref.watch(maxPiecesProvider))}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          ],
        ),
      ),
    );
  }
}
