import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/main.dart';
import 'package:flutter_ecommerce/modules/ui-sections/oauth/login/viewModel/auth-controller.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common-views/custom-text-field.dart';
import '../State/ResetPasswordController.dart';

class ResetPasswordScreen extends StatelessWidget {
  final _controller = Get.put(AuthController());

  ResetPasswordScreen({super.key}) {
    Get.delete<AuthController>(force: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.reset_password_text,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          _buildContent(context),
          _showLoaderIfNeeded(),
          _showErrorIfNeeded(context),
        ],
      ),
    );
  }

  Widget _showLoaderIfNeeded() {
    return Obx(() {
      return _controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Container();
    });
  }

  Widget _showErrorIfNeeded(BuildContext context) {
    return Obx(() {
      return _controller.errorText.value.isNotEmpty
          ? Center(
              child: AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.background,
                title: Text(
                  'Error',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                content: Text(
                  _controller.errorText.value,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      _controller.errorText.value = "";
                      Get.back();
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  )
                ],
              ),
            )
          : Container();
    });
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60, left: 26, right: 26),
      child: Column(
        children: [
          _setImage(),
          const SizedBox(height: 40),
          _addTitleDescription(context),
          const SizedBox(height: 45),
          _buildTextFields(context),
          const SizedBox(height: 30),
          _passwordActionButton(context),
        ],
      ),
    );
  }

  Widget _setImage() {
    return Container(
      width: 220,
      height: 220 * 1.03743,
      alignment: Alignment.topCenter,
      child: Image.asset(
        "utils/assets/images/update-password-thumb.png",
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _addTitleDescription(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.set_new_password_text,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          AppLocalizations.of(context)!.set_complex_password_description,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontWeight: FontWeight.normal,
              fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildTextFields(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: AppLocalizations.of(context)!.new_password_text_field_label,
          placeholder:
              AppLocalizations.of(context)!.new_password_text_field_placeholder,
          controllerValue: _controller.password,
          onChange: (value) {},
          isObscureText: true,
          validator: _controller.validatePassword,
        ),
        const SizedBox(height: 30),
        CustomTextField(
          label:
              AppLocalizations.of(context)!.confirm_password_text_field_label,
          placeholder: AppLocalizations.of(context)!
              .confirm_password_text_field_placeholder,
          controllerValue: _controller.confirmPassword,
          onChange: (value) {},
          isObscureText: true,
          validator: _controller.validatePassword,
        )
      ],
    );
  }

  Widget _passwordActionButton(BuildContext context) {
    return Obx(() {
      return Opacity(
        opacity: (_controller.isValidPassConfirmPass) ? 1.0 : 0.7,
        child: SizedBox(
          width: double.infinity,
          height: 56.0,
          child: ElevatedButton(
            onPressed: (_controller.isValidPassConfirmPass)
                ? () {
                    updatePassword();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              AppLocalizations.of(context)!.set_new_password_text,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
        ),
      );
    });
  }

  void showSuccessDialog(BuildContext context,
      {required String message, String? subMessage}) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents closing the dialog by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 80,
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (subMessage != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    subMessage!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Close the dialog and navigate back to the previous screen
                    Get.back();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void updatePassword() async {
    String newPassword = _controller.confirmPassword.value;
    if (newPassword.isNotEmpty) {
      bool isSuccess = await _controller.updatePassword(newPassword);
      if (isSuccess) {
        showSuccessDialog(navigatorKey.currentContext!,
            message: "Password updated successfully");
      }
    }
  }
}
