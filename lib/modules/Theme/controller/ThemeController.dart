import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../Model/CustomDarkThemeData.dart';
import '../Model/CustomLightThemeData.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  ThemeData get currentTheme => isDarkMode.value ? darkTheme : lightTheme;
}
