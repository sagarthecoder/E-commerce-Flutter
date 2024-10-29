import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/ui-sections/oauth/ResetPassword/Views/ResetPasswordScreen.dart';
import 'package:flutter_ecommerce/modules/ui-sections/oauth/login/viewModel/auth-controller.dart';
import 'package:flutter_ecommerce/modules/ui-sections/oauth/login/views/login-screen.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Theme/views/ThemeSelectionScreen.dart';
import '../../ui-sections/Preferences/Language/Views/LanguageView.dart';
import '../Model/SettingItemEnum.dart';

class SettingScreen extends StatelessWidget {
  final _authController = Get.put(AuthController());

  SettingScreen({super.key}) {
    _authController.isLoading.value = false;
    _authController.errorText.value = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings_tab_text),
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _buildContent(context),
          _showLoaderIfNeeded(),
        ],
      ),
    );
  }

  Widget _showLoaderIfNeeded() {
    return Obx(() {
      return _authController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Container();
    });
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.secondary.withOpacity(0.2),
            Theme.of(context).colorScheme.primary,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          _buildSettingItem(
              context, SettingItem.theme, Icons.color_lens_outlined),
          _buildSettingItem(context, SettingItem.language, Icons.language),
          _buildSettingItem(
              context, SettingItem.resetPassword, Icons.lock_reset_outlined),
          _buildSettingItem(context, SettingItem.profile, Icons.person_outline),
          _buildSettingItem(context, SettingItem.security, Icons.lock_outline),
          _buildSettingItem(context, SettingItem.logout, Icons.logout_outlined),
          const Spacer(),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
      BuildContext context, SettingItem item, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      shadowColor: Theme.of(context).shadowColor,
      child: ListTile(
        leading: Icon(icon,
            color: Theme.of(context).colorScheme.onSurface, size: 28),
        title: Text(
          item.getTitle(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        tileColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: () {
          _handleItemTap(context, item);
        },
      ),
    );
  }

  Widget _buildFooter() {
    return const Column(
      children: [
        Divider(color: Colors.white54),
        Text(
          '© 2024 Movie-Hub',
          style: TextStyle(color: Colors.white54, fontSize: 14),
        ),
      ],
    );
  }

  void _handleItemTap(BuildContext context, SettingItem item) async {
    switch (item) {
      case SettingItem.resetPassword:
        Get.to(() => ResetPasswordScreen());
        break;
      case SettingItem.language:
        Get.to(() => LanguageView());
      case SettingItem.logout:
        bool isSuccess = await _authController.logout();
        if (isSuccess) {
          gotoRoot();
        }
      case SettingItem.theme:
        Get.to(() => ThemeSelectionScreen());
      default:
        break;
    }
  }

  void gotoRoot() async {
    Future.microtask(() => Get.offAll(() => LoginScreen()));
  }
}
