import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvalidMovementDialog extends StatelessWidget {
  const InvalidMovementDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            alignment: Alignment.topCenter,
            child: Card(
              elevation: 10.0,
              child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(
                  maxWidth: 200,
                  maxHeight: 100,
                ),
                padding: const EdgeInsets.all(5.0),
                child: Text(AppLocalizations.of(context)!.invalidMovementText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
