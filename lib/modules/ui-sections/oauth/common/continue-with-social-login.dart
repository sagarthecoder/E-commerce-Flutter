import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../login/model/oauth-enums.dart';

class ContinueWithSocialView extends StatelessWidget {
  final void Function(SocialSignInProvider provider)?
      selectedSocialProviderHandler;
  ContinueWithSocialView({this.selectedSocialProviderHandler, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.or_continue_with,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onBackground,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              makeSocialButton(SocialSignInProvider.google),
              const SizedBox(
                width: 10,
              ),
              makeSocialButton(SocialSignInProvider.facebook),
              const SizedBox(
                width: 10,
              ),
              makeSocialButton(SocialSignInProvider.apple),
            ],
          ),
        ],
      ),
    );
  }

  Widget makeSocialButton(SocialSignInProvider provider) {
    final context = navigator!.context;
    final theme = Theme.of(context);

    return ElevatedButton(
      onPressed: () {
        selectedSocialProviderHandler?.call(provider);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Image.asset(
        height: 50,
        provider.getSocialImagePath(),
      ),
    );
  }
}
