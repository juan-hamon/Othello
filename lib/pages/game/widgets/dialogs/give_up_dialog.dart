import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othello/logic/player/player.dart';

import 'game_over_dialog.dart';

class GiveUpDialog extends StatelessWidget {
  const GiveUpDialog({required this.player, super.key});

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              constraints: const BoxConstraints(
                minWidth: 250,
                maxWidth: 325,
                minHeight: 150,
                maxHeight: 200,
              ),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.giveUpTitleText,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                  const Divider(),
                  const Spacer(),
                  Text(
                    AppLocalizations.of(context)!.giveUpConfirmationText,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FilledButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Future.delayed(const Duration(microseconds: 100), () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return GameOverDialog(
                                  message: AppLocalizations.of(context)!
                                      .giveUpText(player.name),
                                );
                              },
                            );
                          });
                        },
                        child:
                            Text(AppLocalizations.of(context)!.yesButtonText),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      FilledButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(AppLocalizations.of(context)!.noButtonText),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
