import 'dart:ui';

enum LanguageEnum {
  english,
  bangla,
}

extension LanguageEnumExtension on LanguageEnum {
  String getTitle() {
    switch (this) {
      case LanguageEnum.english:
        return "English";
      case LanguageEnum.bangla:
        return "বাংলা";
    }
  }

  Locale getLocale() {
    switch (this) {
      case LanguageEnum.english:
        return Locale('en');
      case LanguageEnum.bangla:
        return Locale('bn');
    }
  }
}
