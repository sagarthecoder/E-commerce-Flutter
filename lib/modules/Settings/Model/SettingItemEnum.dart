import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../main.dart';

enum SettingItem { profile, security, theme, language, resetPassword, logout }

extension SettingItemExtension on SettingItem {
  String getTitle() {
    final context = navigatorKey.currentState?.overlay?.context;
    if (context == null) {
      return fallBackTitle();
    }
    switch (this) {
      case SettingItem.profile:
        return AppLocalizations.of(context)?.profile ?? "Profile";
      case SettingItem.security:
        return AppLocalizations.of(context)?.security ?? "Security";
      case SettingItem.theme:
        return AppLocalizations.of(context)?.theme ?? "Theme";
      case SettingItem.language:
        return AppLocalizations.of(context)?.language ?? "Language";
      case SettingItem.resetPassword:
        return AppLocalizations.of(context)?.reset_password_text ??
            "Reset Password";
      case SettingItem.logout:
        return AppLocalizations.of(context)?.logout_text ?? "Logout";
    }
  }

  String fallBackTitle() {
    switch (this) {
      case SettingItem.profile:
        return "Profile";
      case SettingItem.security:
        return "Security";
      case SettingItem.theme:
        return "Theme";
      case SettingItem.language:
        return "Language";
      case SettingItem.resetPassword:
        return "Reset password";
      case SettingItem.logout:
        return "Logout";
    }
  }
}
