import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../helpers/AppConstants.dart';
import '../../../../../l10n/l10n.dart';

class LanguageController extends GetxController {
  final languages = L10n.all;
  var currentLocale = L10n.all[0].obs;

  LanguageController() {
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedLanguageCode =
        await prefs.getString(AppConstants.selectedLocalizedLanguageCodeKey);
    print("Cached response ${cachedLanguageCode}");
    if (cachedLanguageCode == null) {
      return;
    }
    for (int i = 0; i < languages.length; i++) {
      if (languages[i].languageCode == cachedLanguageCode) {
        currentLocale.value = languages[i];
      }
    }
    Get.updateLocale(currentLocale.value);
    print("pre Selected langugae = ${currentLocale.value.languageCode}");
  }

  Future<void> setNewLanguage(Locale locale) async {
    await addToDB(locale);
    currentLocale.value = locale;
    Get.updateLocale(currentLocale.value);
  }

  Future<void> addToDB(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(
          AppConstants.selectedLocalizedLanguageCodeKey, locale.languageCode);
    } catch (err) {
      print("language error = ${err.toString()}");
    }
  }
}
