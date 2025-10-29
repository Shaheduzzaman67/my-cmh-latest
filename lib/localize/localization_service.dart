import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cmh_updated/common/sessions.dart';
import 'package:my_cmh_updated/common/shared_pref_key.dart';
import 'package:my_cmh_updated/localize/app_labels.dart';
import 'package:my_cmh_updated/localize/bn_bd.dart';
import 'package:my_cmh_updated/localize/en_us.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService extends Translations {
  // Default locale
  static const locale = Locale('bn', 'BD');
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale = Locale('en', 'US');

  // Supported languages
  // Needs to be same order with locales
  static final langs = ['English', 'Bangla'];

  // Supported locales
  // Needs to be same order with langs
  static const locales = [Locale('en', 'US'), Locale('bn', 'BD')];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUS, 'bn_BD': bnBD};

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) async {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(SharedPreferenceKeys.language, lang);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale!;
  }
}
