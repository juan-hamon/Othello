import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:othello/logic/player/player.dart';
import 'package:othello/pages/home/widgets/widgets.dart';
import 'package:othello/providers/player/player.dart';

class PlayerCard extends ConsumerStatefulWidget {
  const PlayerCard({required this.playerId, required this.formKey, super.key});

  final int playerId;
  final GlobalKey<FormState> formKey;

  @override
  ConsumerState<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends ConsumerState<PlayerCard> {
  late TextEditingController _nameController;

  @override
  void initState() {
    _nameController =
        TextEditingController(text: ref.read(namesProviders[widget.playerId]!));
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Theme.of(context).shadowColor,
      elevation: 10.0,
      child: Form(
        key: widget.formKey,
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
                AppLocalizations.of(context)!.playerCardTitle(widget.playerId),
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
                    playerId: widget.playerId,
                    optionValue: 1,
                    color: Colors.white,
                  ),
                  ColorPick(
                    playerId: widget.playerId,
                    optionValue: 2,
                    color: Colors.black,
                  ),
                ],
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.playerNameHint,
                ),
                onChanged: (String? nValue) {
                  if (nValue != null && nValue.isNotEmpty) {
                    ref.read(namesProviders[widget.playerId]!.notifier).state =
                        nValue;
                  }
                },
                onSaved: (String? newValue) {
                  ref.read(namesProviders[widget.playerId]!.notifier).state =
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
