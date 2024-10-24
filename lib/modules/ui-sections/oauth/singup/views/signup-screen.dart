import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/ui-sections/home/views/home-page.dart';
import 'package:flutter_ecommerce/modules/ui-sections/oauth/common/continue-with-social-login.dart';
import 'package:flutter_ecommerce/modules/ui-sections/oauth/login/model/oauth-enums.dart';
import 'package:flutter_ecommerce/modules/ui-sections/oauth/login/viewModel/auth-controller.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common-views/custom-text-field.dart';

class SignupScreen extends StatelessWidget {
  final _controller = Get.put(AuthController()); //<AuthController>();
  SignupScreen({super.key}) {
    Get.delete<AuthController>(force: true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primaryContainer,
        toolbarHeight: 30,
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 31, right: 31),
            child: Column(children: [
              _buildTitle(context),
              const SizedBox(
                height: 40,
              ),
              buildTextFields(context),
              const SizedBox(
                height: 50,
              ),
              makeSignUpButton(),
              const SizedBox(
                height: 30,
              ),
              _buildRichText(),
              const SizedBox(
                height: 60,
              ),
              ContinueWithSocialView(
                selectedSocialProviderHandler: (provider) {
                  socialLogin(provider);
                },
              ),
            ]),
          ),
          showLoaderIfNeeded(),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        AppLocalizations.of(context)!.sign_up_screen_title,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onBackground,
        ),
      ),
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

  showAlertDialog(String message, [String title = 'Alert!']) {
    final context = navigator!.context;
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK",
          style: TextStyle(color: Theme.of(context).colorScheme.primary)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title,
          style: TextStyle(color: Theme.of(context).colorScheme.primary)),
      content: Text(message),
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

  Widget buildTextFields(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: AppLocalizations.of(context)!.email_text_field_label,
          placeholder:
              AppLocalizations.of(context)!.email_text_field_placeholder,
          controllerValue: _controller.email,
          onChange: (value) {},
          isObscureText: false,
          validator: _controller.validateEmail,
        ),
        const SizedBox(
          height: 26,
        ),
        CustomTextField(
          label: AppLocalizations.of(context)!.password_text_field_label,
          placeholder:
              AppLocalizations.of(context)!.password_text_field_placeholder,
          controllerValue: _controller.password,
          onChange: (value) {},
          isObscureText: true,
          validator: _controller.validatePassword,
        ),
        const SizedBox(
          height: 26,
        ),
        CustomTextField(
          label:
              AppLocalizations.of(context)!.confirm_password_text_field_label,
          placeholder: AppLocalizations.of(context)!
              .confirm_password_text_field_placeholder,
          controllerValue: _controller.confirmPassword,
          onChange: (value) {},
          isObscureText: true,
          validator: _controller.validatePassword,
        ),
      ],
    );
  }

  Widget _buildRichText() {
    final context = navigator!.context;
    final theme = Theme.of(context);
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: "${AppLocalizations.of(context)!.already_have_an_account} ",
          style: TextStyle(
              color: theme.colorScheme.onBackground.withOpacity(0.7),
              fontSize: 14)),
      TextSpan(
        text: AppLocalizations.of(context)!.sign_in_button_text,
        style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 11),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            Get.back();
          },
      )
    ]));
  }

  Widget makeSignUpButton() {
    final context = navigator!.context;
    final theme = Theme.of(context);
    return Obx(() {
      bool isValid = _controller.isValidEmailPassConfirmPass;
      return SizedBox(
        width: double.infinity,
        height: 54,
        child: Opacity(
          opacity: isValid ? 1.0 : 0.4,
          child: ElevatedButton(
              onPressed: isValid
                  ? () async {
                      signupButtonAction();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.secondary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                AppLocalizations.of(context)!.signupText,
                style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onPrimary, fontSize: 16),
              )),
        ),
      );
    });
  }

  Future<void> signupButtonAction() async {
    bool success = await _controller.signup();
    if (success) {
      gotoHome();
    } else {
      showAlertDialog(_controller.errorText.value);
    }
  }

  Future<void> socialLogin(SocialSignInProvider provider) async {
    switch (provider) {
      case SocialSignInProvider.google:
        bool success = await _controller.googleLogin();
        if (success) {
          gotoHome();
        } else if (_controller.errorText.value.isNotEmpty) {
          showAlertDialog(_controller.errorText.value);
        }
      default:
        break;
    }
  }

  void gotoHome() {
    Future.microtask(() => Get.to(() => HomePage()));
  }
}
