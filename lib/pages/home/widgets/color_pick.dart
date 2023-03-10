import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:othello/providers/providers.dart';

class ColorPick extends ConsumerWidget {
  const ColorPick({
    required this.playerId,
    required this.optionValue,
    required this.color,
    super.key,
  });

  /// Specifies the player id, used to storage his/her decision.
  final int playerId;

  /// Specifies the numeric value of the color (1 -> White, 2 -> Black)
  final int optionValue;

  /// Specifies the color to pick.
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Container(
          height: 40,
          width: 45,
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  ref.watch(selectedOptionProviders[playerId]!) == optionValue
                      ? Theme.of(context).colorScheme.surfaceTint
                      : Colors.transparent,
              width: 3.0,
            ),
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        onTap: () {
          final selectedOptionNotifier =
              selectedOptionProviders[playerId]!.notifier;
          final selectedColorNotifier =
              selectedColorProviders[playerId]!.notifier;
          ref.read(selectedOptionNotifier).state = optionValue;
          ref.read(selectedColorNotifier).state = color;
        },
      ),
    );
  }
}
