import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/ui-sections/home/views/home-page.dart';
import 'package:flutter_ecommerce/modules/ui-sections/oauth/common/continue-with-social-login.dart';
import 'package:flutter_ecommerce/modules/ui-sections/oauth/login/model/oauth-enums.dart';
import 'package:flutter_ecommerce/modules/ui-sections/oauth/login/viewModel/auth-controller.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common-views/custom-text-field.dart';

class LoginScreen extends StatelessWidget {
  final controller = Get.put(AuthController());
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
      ),
      body: Stack(children: [
        Container(
          margin: const EdgeInsets.only(top: 20, left: 31, right: 31),
          child: Column(children: [
            _buildTitle(context),
            const SizedBox(
              height: 40,
            ),
            _buildTextFields(),
            _buildForgetPassword(),
            const SizedBox(
              height: 26,
            ),
            makeSignInButton(),
            const SizedBox(
              height: 40,
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
      ]),
    );
  }

  Widget _buildTitle(BuildContext context) {
    var theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        AppLocalizations.of(context)!.sign_in_button_text,
        style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onBackground, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget showLoaderIfNeeded() {
    return Obx(() {
      if (controller.isLoading.value) {
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

  Widget _buildForgetPassword() {
    final context = navigator!.context;
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
            onPressed: () {
              //Get.to(() => ForgetPasswordView());
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                AppLocalizations.of(context)!.forgot_password_text,
                style: TextStyle(color: theme.colorScheme.primary),
              ),
            )),
      ),
    );
  }

  Widget _buildTextFields() {
    final context = navigator!.context;
    return Column(
      children: [
        CustomTextField(
          label: AppLocalizations.of(context)!.email_text_field_label,
          controllerValue: controller.email,
          onChange: (value) {},
          isObscureText: false,
          validator: controller.validateEmail,
        ),
        const SizedBox(
          height: 26,
        ),
        CustomTextField(
          label: AppLocalizations.of(context)!.password_text_field_label,
          controllerValue: controller.password,
          onChange: (value) {},
          isObscureText: false,
          validator: controller.validatePassword,
        )
      ],
    );
  }

  Widget _buildRichText() {
    final context = navigator!.context;
    final theme = Theme.of(context);
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: "${AppLocalizations.of(context)!.dont_have_account_text} ",
          style: TextStyle(
              color: theme.colorScheme.onBackground.withOpacity(0.7),
              fontSize: 14)),
      TextSpan(
        text: AppLocalizations.of(context)!.signupText,
        style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 11),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            // Navigator.push(context, MaterialPageRoute(builder: (_) {
            //   return const SignupScreen();
            // }));
          },
      )
    ]));
  }

  Widget makeSignInButton() {
    final context = navigator!.context;
    return Obx(() {
      bool isValid = controller.isValidEmailPass;
      print("Is valid = ${isValid}");
      return SizedBox(
        width: double.infinity,
        height: 54,
        child: Opacity(
          opacity: isValid ? 1.0 : 0.4,
          child: ElevatedButton(
              onPressed: isValid
                  ? () async {
                      signInButtonAction();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: Text(
                AppLocalizations.of(context)!.sign_in_button_text,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              )),
        ),
      );
    });
  }

  void gotoHome() {
    Future.microtask(() => Get.to(() => HomePage()));
  }

  Future<void> signInButtonAction() async {
    bool success = await controller.loginWithEmail();
    if (success) {
      gotoHome();
    } else {
      showAlertDialog(controller.errorText.value);
    }
  }

  Future<void> socialLogin(SocialSignInProvider provider) async {
    switch (provider) {
      case SocialSignInProvider.google:
        bool success = await controller.googleLogin();
        if (success) {
          gotoHome();
        } else if (controller.errorText.value.isNotEmpty) {
          showAlertDialog(controller.errorText.value);
        }
      default:
        break;
    }
  }
}
