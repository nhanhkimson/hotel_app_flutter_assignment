import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Language service for managing app language
class LanguageService extends ChangeNotifier {
  static final LanguageService _instance = LanguageService._internal();
  factory LanguageService() => _instance;
  LanguageService._internal();

  Locale _currentLocale = const Locale('en'); // Default to English

  Locale get currentLocale => _currentLocale;
  String get currentLanguage => _currentLocale.languageCode;
  bool get isEnglish => _currentLocale.languageCode == 'en';
  bool get isKhmer => _currentLocale.languageCode == 'km';

  /// Set app language
  void setLanguage(String languageCode) {
    if (languageCode == 'en' || languageCode == 'km') {
      if (_currentLocale.languageCode != languageCode) {
        _currentLocale = Locale(languageCode);
        notifyListeners();
      }
    }
  }

  /// Change language (alias for setLanguage)
  void changeLanguage(String languageCode) {
    setLanguage(languageCode);
  }

  /// Get language name
  String getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'km':
        return 'ភាសាខ្មែរ'; // Khmer
      default:
        return 'English';
    }
  }
}

