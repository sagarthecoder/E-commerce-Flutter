import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/ui-sections/home/views/home-page.dart';
import 'package:flutter_ecommerce/modules/ui-sections/oauth/login/views/login-screen.dart';
import 'package:get/get.dart';

import 'modules/Theme/Controller/ThemeController.dart';
import 'modules/ui-sections/Preferences/Language/Controller/LanguageController.dart';
import "package:flutter_localizations/flutter_localizations.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'l10n/l10n.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(LanguageController());
  Get.put(ThemeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final languageController = Get.find<LanguageController>();
  final themeController = Get.find<ThemeController>();
  MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print(
          "Rebuild locale = ${languageController.currentLocale.value.languageCode}");

      return GetMaterialApp(
        title: 'Movie Hub',
        debugShowCheckedModeBanner: false,
        supportedLocales: L10n.all,
        locale: languageController.currentLocale.value,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        navigatorKey: navigatorKey,
        theme: themeController.currentTheme,
        home: LoginScreen(),
      );
    });
  }
}
