import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:othello/pages/home/widgets/widgets.dart';
import 'package:othello/providers/providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  /// Validates that the names of each player are valid, that each one has selected
  /// a different color and name and that the board dimensions are valid.
  void validateInput(
    GlobalKey<FormState> playerOneKey,
    GlobalKey<FormState> playerTwoKey,
    GlobalKey<FormState> boardSizeInputKey,
    WidgetRef ref,
  ) {
    // TODO: Validate that the players selected different colors and have different names.
    final bool isPlayerOneValid = playerOneKey.currentState!.validate();
    final bool isPlayerTwoValid = playerTwoKey.currentState!.validate();
    final bool changeSizeSelected = ref.read(dynamicBoardSizeProvider);
    final bool areDimensionValid = (changeSizeSelected)
        ? boardSizeInputKey.currentState!.validate()
        : true;
    if (isPlayerOneValid && isPlayerTwoValid && areDimensionValid) {
      playerOneKey.currentState!.save();
      playerTwoKey.currentState!.save();
      boardSizeInputKey.currentState!.save();
      // TODO: Go to game page.
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> playerOneKey = GlobalKey<FormState>();
    final GlobalKey<FormState> playerTwoKey = GlobalKey<FormState>();
    final GlobalKey<FormState> boardSizeInputKey = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.quiz),
                    color: Colors.white,
                  ),
                  Text(
                    AppLocalizations.of(context)!.mainTitle,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => const SettingsDialog(),
                    ),
                    icon: const Icon(Icons.settings),
                    color: Colors.white,
                  )
                ],
              ),
            ),
            const Spacer(flex: 3),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 50.0,
              runSpacing: 30.0,
              children: [
                PlayerCard(
                  playerId: 1,
                  formKey: playerOneKey,
                ),
                PlayerCard(
                  playerId: 2,
                  formKey: playerTwoKey,
                ),
              ],
            ),
            const Spacer(flex: 1),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 660,
                minWidth: 300,
                maxHeight: 250,
                minHeight: 100,
              ),
              child: Card(
                elevation: 10.0,
                child: GameOptionCard(formKey: boardSizeInputKey),
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => validateInput(
                playerOneKey,
                playerTwoKey,
                boardSizeInputKey,
                ref,
              ),
              icon: const Icon(Icons.check),
              label: Text(AppLocalizations.of(context)!.statGameText),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
