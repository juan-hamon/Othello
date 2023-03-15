import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:othello/pages/home/widgets/widgets.dart';
import 'package:othello/providers/providers.dart';

class GameOptionCard extends ConsumerWidget {
  const GameOptionCard({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  /// Changes the state of the provider specified in the parameters
  void changeProviderValue(
    bool? nValue,
    StateProvider provider,
    WidgetRef ref,
  ) {
    if (nValue != null) {
      ref.read(provider.notifier).state = nValue;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool changeSizeSelected = ref.watch(dynamicBoardSizeProvider);
    return Container(
      padding: changeSizeSelected
          ? const EdgeInsets.all(10.0)
          : const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: ref.watch(allowDiagonalsProvider),
                    onChanged: (bool? nValue) => changeProviderValue(
                      nValue,
                      allowDiagonalsProvider,
                      ref,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.enableDiagonalsOption,
                  )
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: changeSizeSelected,
                    onChanged: (bool? nValue) => changeProviderValue(
                      nValue,
                      dynamicBoardSizeProvider,
                      ref,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.changeBoardSizeOption,
                  )
                ],
              ),
            ],
          ),
          (changeSizeSelected)
              ? BoardSizeInput(formKey: formKey)
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
