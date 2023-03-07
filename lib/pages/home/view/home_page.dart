import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:othello/pages/home/widgets/widgets.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKeyPlayerOne = GlobalKey<FormState>();
    final GlobalKey<FormState> formKeyPlayerTwo = GlobalKey<FormState>();
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
                    onPressed: () => {},
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
                  formKey: formKeyPlayerOne,
                ),
                PlayerCard(
                  playerId: 2,
                  formKey: formKeyPlayerTwo,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          // TODO: Allow to enable diagonal movements.
                          onChanged: (_) {},
                        ),
                        Text(
                          AppLocalizations.of(context)!.enableDiagonalsOption,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          // TODO: Allow to change the board size.
                          onChanged: (_) {},
                        ),
                        Text(
                          AppLocalizations.of(context)!.changeBoardSizeOption,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                bool isPlayerOneValid =
                    formKeyPlayerOne.currentState!.validate();
                bool isPlayerTwoValid =
                    formKeyPlayerTwo.currentState!.validate();
                if (isPlayerOneValid && isPlayerTwoValid) {
                  // TODO: Go to game page.
                }
              },
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
