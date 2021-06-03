import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alpro_physio/ProBaseState/export.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale(LANG_EN);

  static const String LANG_EN = 'en';
  static const String LANG_BM = 'ms';
  static const String LANG_CN = 'cn';
  final String KEY_LANGUAGE_CODE = 'language_code';

  Locale get appLocale => _appLocale ?? Locale(LANG_EN);

  Future<Locale> fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.get(KEY_LANGUAGE_CODE) == null) {
      _appLocale = Locale(LANG_EN);
    } else {
      _appLocale = Locale(prefs.get(KEY_LANGUAGE_CODE));
    }

    return _appLocale;
  }

  Future<String> fetchLanguageCode() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.get(KEY_LANGUAGE_CODE) == null) {
      return LANG_EN;
    } else {
      return prefs.get(KEY_LANGUAGE_CODE);
    }
  }

  void changeLanguage(String langCode) async {
    var prefs = await SharedPreferences.getInstance();

    _appLocale = Locale(langCode);
    await prefs.setString(KEY_LANGUAGE_CODE, langCode);
    languageCode = langCode;
    notifyListeners();
  }
}
