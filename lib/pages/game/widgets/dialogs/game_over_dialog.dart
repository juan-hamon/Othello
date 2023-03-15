import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:othello/providers/providers.dart';

/// This provider is used for the hide dialog option, allowing
/// the players to see the board after the game is over.
final visibilityProvider = StateProvider<bool>((ref) => true);

class GameOverDialog extends ConsumerWidget {
  const GameOverDialog({required this.message, super.key});

  final String message;

  Color obtainTitleColor(BuildContext context) {
    if (message.contains(AppLocalizations.of(context)!.lostKey)) {
      return Colors.red;
    } else if (message.contains(AppLocalizations.of(context)!.winKey)) {
      return Colors.green;
    }
    return Colors.amber;
  }

  String obtainTitle(BuildContext context) {
    if (message.contains(AppLocalizations.of(context)!.lostKey)) {
      return AppLocalizations.of(context)!.defeatTitleText;
    } else if (message.contains(AppLocalizations.of(context)!.winKey)) {
      return AppLocalizations.of(context)!.victoryTitleText;
    }
    return AppLocalizations.of(context)!.drawTitleText;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isVisible = ref.watch(visibilityProvider);
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: AnimatedOpacity(
          opacity: ref.watch(visibilityProvider) ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
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
                      obtainTitle(context),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: obtainTitleColor(context)),
                    ),
                    const Divider(),
                    const Spacer(),
                    Text(
                      message,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FilledButton(
                          onPressed: isVisible
                              ? () {
                                  ref.read(visibilityProvider.notifier).state =
                                      false;
                                  Future.delayed(
                                    const Duration(seconds: 5),
                                    () {
                                      ref
                                          .read(visibilityProvider.notifier)
                                          .state = true;
                                    },
                                  );
                                }
                              : null,
                          child: Text(AppLocalizations.of(context)!
                              .hideDialogButtonText),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        FilledButton(
                          onPressed: isVisible
                              ? () {
                                  selectedColorProviders.forEach((key, value) {
                                    ref.invalidate(value);
                                  });
                                  ref.invalidate(notifierServiceProvider);
                                  ref.invalidate(boardServiceProvider);
                                  ref.invalidate(boardProvider);
                                  ref.invalidate(maxPiecesProvider);
                                  ref.invalidate(allowDiagonalsProvider);
                                  ref.invalidate(dynamicBoardSizeProvider);
                                  ref.invalidate(boardDimensionProvider);
                                  ref.invalidate(playersProvider);
                                  selectedOptionProviders.forEach((key, value) {
                                    ref.invalidate(value);
                                  });
                                  selectedColorProviders.forEach((key, value) {
                                    ref.invalidate(value);
                                  });
                                  namesProviders.forEach((key, value) {
                                    ref.invalidate(value);
                                  });
                                  GoRouter.of(context).go('/');
                                }
                              : null,
                          child: Text(
                            AppLocalizations.of(context)!.goToMenuButtonText,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
