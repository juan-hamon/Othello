import 'package:flutter/material.dart';

class InGamePlayerCard extends StatelessWidget {
  const InGamePlayerCard({
    required this.playerName,
    required this.playerColor,
    required this.playerPieces,
    super.key,
  });

  final String playerName;
  final Color playerColor;
  final int playerPieces;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shadowColor: Theme.of(context).shadowColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // TODO: Highlight the current player
          border: Border.all(color: Colors.transparent, width: 2.0),
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
              playerName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ListTile(
              leading: Container(
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: playerColor,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.flag,
                ),
                color: Colors.red,
                // TODO: Disable the button when it's not the player turn (assign this to null).
                onPressed: () {},
              ),
              title: Text(
                "x$playerPieces",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          ],
        ),
      ),
    );
  }
}
