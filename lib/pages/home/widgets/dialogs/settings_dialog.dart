import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:othello/providers/providers.dart';

class SettingsDialog extends ConsumerWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                maxWidth: 300,
                minHeight: 325,
                maxHeight: 375,
              ),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.settingsTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Divider(),
                  Text(
                    AppLocalizations.of(context)!.appearanceTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  RadioListTile(
                    value: Brightness.light,
                    groupValue: ref.watch(themeProvider),
                    onChanged: (value) => ref
                        .read(themeProvider.notifier)
                        .state = Brightness.light,
                    title: Text(AppLocalizations.of(context)!.lightThemOption),
                  ),
                  RadioListTile(
                    value: Brightness.dark,
                    groupValue: ref.watch(themeProvider),
                    onChanged: (value) => ref
                        .read(themeProvider.notifier)
                        .state = Brightness.dark,
                    title: Text(AppLocalizations.of(context)!.darkThemeOption),
                  ),
                  const Divider(),
                  Text(
                    AppLocalizations.of(context)!.languageTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  RadioListTile(
                    value: const Locale('en'),
                    groupValue: ref.watch(languageProvider).locale,
                    onChanged: (value) => ref
                        .read(languageProvider)
                        .changeLanguage(const Locale('en')),
                    title: Text(AppLocalizations.of(context)!.englishOption),
                  ),
                  RadioListTile(
                    value: const Locale('es'),
                    groupValue: ref.watch(languageProvider).locale,
                    onChanged: (value) => ref
                        .read(languageProvider)
                        .changeLanguage(const Locale('es')),
                    title: Text(AppLocalizations.of(context)!.spanishOption),
                  ),
                  const Divider(),
                  const Spacer(),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(AppLocalizations.of(context)!.doneButtonText),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
