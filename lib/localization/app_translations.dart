import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppTranslations {
  Locale locale;
  static Map<String, dynamic> _localisedValues;

  AppTranslations(Locale locale) {
    this.locale = locale;
  }

  static AppTranslations of(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations);
  }

  static Future<AppTranslations> load(Locale locale) async {
    AppTranslations appTranslations = AppTranslations(locale);
    String jsonContent =
    await rootBundle.loadString('assets/locale/localization_${locale.languageCode}.json');
    _localisedValues = json.decode(jsonContent) as Map<String,dynamic>;
    return appTranslations;
  }

  String get currentLanguage => locale.languageCode;

  String text(String key) {
    return (_localisedValues[key] ?? '$key not found') as String;
  }
}