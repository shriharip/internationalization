

 import 'dart:async';
 import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:internationalization/utils/preferences.dart';

import 'package:internationalization/utils/global_translations.dart';

class Translations with ChangeNotifier {
  
 StreamController<String> _languageController = StreamController<String>.broadcast();
  Stream<String> get currentLanguage => _languageController.stream;

  StreamController<Locale> _localeController = StreamController<Locale>();
  Stream<Locale> get currentLocale => _localeController.stream;

  // getLanguage() => _language;
  // getLocale() => _locale;

  // setLanguage(String language) => _language = language;

  @override
  void dispose() {
    _languageController?.close();
    _localeController?.close();
    super.dispose();
  }

void setNewLanguage(String newLanguage) async {
    // Save the selected language as a user preference
    await preferences.setPreferredLanguage(newLanguage);
    
    // Notification the translations module about the new language
    await allTranslations.setNewLanguage(newLanguage);
  
  _languageController.sink.add(newLanguage);
    _localeController.sink.add(allTranslations.locale);
   notifyListeners();
  }


}