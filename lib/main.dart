import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/controller/product-controller.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/services/product-service.dart';
import 'package:flutter_ecommerce/modules/ui-sections/home/views/home-page.dart';
import 'package:flutter_ecommerce/modules/ui-sections/oauth/login/views/login-screen.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
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
  Get.put(ProductController(service: ProductService()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final languageController = Get.find<LanguageController>();
  final themeController = Get.find<ThemeController>();
  final RxBool _isJailbreakDevice = false.obs;
  MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    checkJailbroken();
    return Obx(() {
      print(
          "Rebuild locale = ${languageController.currentLocale.value.languageCode}");

      return GetMaterialApp(
        title: 'My Store',
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
        home: (_isJailbreakDevice.value == false)
            ? LoginScreen()
            : showJailBrokenMessage(),
      );
    });
  }

  Future<void> checkJailbroken() async {
    try {
      _isJailbreakDevice.value = await FlutterJailbreakDetection.jailbroken;
    } on PlatformException {
      _isJailbreakDevice.value = true;
    }
  }

  Widget showJailBrokenMessage() {
    return const Scaffold(
      body: Center(
        child: Text("App is disabled on jailbroken devices."),
      ),
    );
  }
}
