import 'package:flutter/material.dart';
import 'package:OEGlobal/language/label_util.dart';
import 'package:OEGlobal/language/app_language.dart';
import 'package:OEGlobal/model/label.dart';
import 'package:OEGlobal/ProBaseState/export.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  List<Label> _labels = List();

  Future<bool> load() async {
    print('load');
    // Load the language from file
    LabelUtil labelUtil = LabelUtil.instance;
    _labels = await labelUtil.getLabels(languageCode);
//    _labels.forEach((label) => print('const ${label.key} = \'${label.key}\';'));

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    try {
      String value = _labels.firstWhere((item) => item.key == key).value;
      if (value.isEmpty) {
        return null;
      }
      return value;
    } catch (e) {
      return null;
    }
  }
}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations object
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return [AppLanguage.LANG_EN, AppLanguage.LANG_BM]
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => true;
}
