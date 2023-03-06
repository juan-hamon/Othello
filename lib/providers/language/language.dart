import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This provider exposes a [LanguageChangeNotifier] instance
/// that allows to change the language of the application.
final languageProvider = ChangeNotifierProvider<LanguageChangeNotifier>(
  (ref) => LanguageChangeNotifier(),
);

/// This class is used to change the current locale of the
/// application.
class LanguageChangeNotifier extends ChangeNotifier {
  Locale _locale = const Locale('en');

  /// Obtains the current locale.
  Locale get locale => _locale;

  /// Changes the current locale.
  void changeLanguage(Locale nLocale) {
    if (!AppLocalizations.supportedLocales.contains(nLocale)) {
      return;
    }
    _locale = nLocale;
    notifyListeners();
  }
}
