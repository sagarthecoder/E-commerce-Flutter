import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/ui-sections/oauth/login/viewModel/auth-controller.dart';
import 'package:flutter_ecommerce/modules/ui-sections/oauth/login/views/login-screen.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common-views/custom-text-field.dart';

class ForgetPasswordView extends StatelessWidget {
  final _controller = Get.put(AuthController()); //<AuthController>();

  ForgetPasswordView({super.key}) {
    Get.delete<AuthController>(force: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          _buildContent(context),
          showLoaderIfNeeded(),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildEmailTextField(context),
            const SizedBox(height: 20),
            _buildForgotPasswordButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailTextField(BuildContext context) {
    return CustomTextField(
      label: AppLocalizations.of(context)!.email_text_field_label,
      placeholder: AppLocalizations.of(context)!.email_text_field_placeholder,
      controllerValue: _controller.email,
      onChange: (value) {},
      isObscureText: false,
      validator: _controller.validateEmail,
    );
  }

  Widget showLoaderIfNeeded() {
    return Obx(() {
      if (_controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Container();
      }
    });
  }

  showSuccessAlertDialog() {
    final context = navigator!.context;
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK",
          style: TextStyle(color: Theme.of(context).colorScheme.primary)),
      onPressed: () {
        _controller.reset();
        Get.offAll(() => LoginScreen());
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(
        AppLocalizations.of(context)!.check_your_email_text,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
      content: Text(
        '${AppLocalizations.of(context)!.password_reset_link_email_description} ${_controller.email.value}',
        style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _buildForgotPasswordButton(BuildContext context) {
    return Obx(() {
      bool isValid = _controller.validateEmail(_controller.email.value) == null;
      return Opacity(
        opacity: isValid ? 1.0 : 0.7,
        child: SizedBox(
          width: double.infinity,
          height: 56.0,
          child: ElevatedButton(
            onPressed: isValid
                ? () async {
                    forgotPasswordAction();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(
              AppLocalizations.of(context)!.reset_password_text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> forgotPasswordAction() async {
    bool success =
        await _controller.sendResetPasswordEmail(_controller.email.value);
    if (success) {
      showSuccessAlertDialog();
    } else {}
  }
}
