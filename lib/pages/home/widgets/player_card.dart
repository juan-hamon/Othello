import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:othello/logic/player/player.dart';
import 'package:othello/pages/home/widgets/widgets.dart';
import 'package:othello/providers/player/player.dart';

class PlayerCard extends ConsumerWidget {
  const PlayerCard({required this.playerId, required this.formKey, super.key});

  final int playerId;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shadowColor: Theme.of(context).shadowColor,
      elevation: 10.0,
      child: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          constraints: const BoxConstraints(
            maxWidth: 300,
            maxHeight: 250,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                AppLocalizations.of(context)!.playerCardTitle(playerId),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                AppLocalizations.of(context)!.playerSelectColor,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: 10.0,
                children: [
                  ColorPick(
                    playerId: playerId,
                    optionValue: 1,
                    color: Colors.white,
                  ),
                  ColorPick(
                    playerId: playerId,
                    optionValue: 2,
                    color: Colors.black,
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.playerNameHint,
                ),
                onSaved: (String? newValue) {
                  ref.read(namesProviders[playerId]!.notifier).state =
                      newValue!;
                },
                maxLength: 20,
                validator: PlayerValidator.isValidName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
