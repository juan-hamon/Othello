import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:othello/pages/game/widgets/widgets.dart';
import 'package:othello/providers/providers.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int boardDimension = ref.watch(boardDimensionProvider);
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: InGamePlayerCard(
                  playerName: ref.read(namesProviders[1]!),
                  playerColor: ref.read(selectedColorProviders[1]!),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(3.0),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      mainAxisSpacing: 1.5,
                      crossAxisSpacing: 1.5,
                      crossAxisCount: boardDimension,
                      children: List.generate(
                        boardDimension * boardDimension,
                        // TODO: Add the first 4 pieces on the board.
                        (int index) {
                          return Container(
                            color: Colors.green,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: InGamePlayerCard(
                  playerName: ref.read(namesProviders[2]!),
                  playerColor: ref.read(selectedColorProviders[2]!),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
