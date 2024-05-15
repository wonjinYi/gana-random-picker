import 'package:flutter/material.dart';
import 'package:mobile/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile/utils/enum_contains.dart';
import 'dart:ui' as ui;

Language defaultLanguage = Language.en;
Locale systemLocale = ui.PlatformDispatcher.instance.locale;
ThemeName defaultThemeName = ThemeName.light;
ThemeMode systemThemeMode = ThemeMode.system;

class SettingModel extends ChangeNotifier {
  Language _language = defaultLanguage;
  Locale _locale = systemLocale;

  ThemeName _themeName = defaultThemeName;
  ThemeMode _themeMode = ThemeMode.system;

  get language => _language;
  get locale => _locale;
  get themeName => _themeName;
  get themeMode => _themeMode;

  SettingModel() {
    initSettingValues();
  }

  Future<void> initSettingValues() async {
    final prefs = await SharedPreferences.getInstance();

    // language and locale
    final String languageStr =
        prefs.getString('language') ?? defaultLanguage.name;
    final bool isLanguagePrefValid = enumContains(Language.values, languageStr);

    _language = isLanguagePrefValid
        ? Language.values.byName(languageStr)
        : defaultLanguage;
    _locale = getLocaleByLanguage(_language);

    // theme name
    final String themeNameStr =
        prefs.getString('themeName') ?? defaultThemeName.name;
    final bool isThemeNamePrefValid =
        enumContains(ThemeName.values, themeNameStr);

    _themeName = isThemeNamePrefValid
        ? ThemeName.values.byName(themeNameStr)
        : defaultThemeName;
    _themeMode = ThemeMode.values.byName(_themeName.name);

    notifyListeners();
  }

  void updateLanguage(Language language) async {
    _language = language;
    _locale = getLocaleByLanguage(_language);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language.name);
  }

  void updateThemeName(ThemeName themeName) async {
    _themeName = themeName;
    _themeMode = ThemeMode.values.byName(themeName.name);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeName', themeName.name);
  }

  Locale getLocaleByLanguage(Language language) {
    switch (language) {
      case Language.en:
        return const Locale('en', '');
      case Language.ko:
        return const Locale('ko', '');
      default:
        return systemLocale;
    }
  }

  void resetAll() {
    updateLanguage(defaultLanguage);
    updateThemeName(defaultThemeName);
  }
}
