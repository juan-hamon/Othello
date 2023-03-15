import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({required this.errorMessage, super.key});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              constraints: const BoxConstraints(
                minWidth: 150,
                maxWidth: 300,
                minHeight: 150,
                maxHeight: 250,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.warningTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    errorMessage,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: FilledButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(AppLocalizations.of(context)!.okButtonText),
                    ),
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
