import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('en'));

  Future<void> setLocale(Locale newLocale) async {
    state = newLocale;
    await saveLocaleToPrefs(newLocale);
  }

  Future<void> saveLocaleToPrefs(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('appLocale', locale.languageCode);
  }

  Future<void> loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocaleCode = prefs.getString('appLocale');
    if (savedLocaleCode != null) {
      state = Locale(savedLocaleCode);
    }
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);