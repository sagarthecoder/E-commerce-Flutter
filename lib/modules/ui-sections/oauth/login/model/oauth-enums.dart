enum SocialSignInProvider {
  google,
  facebook,
  apple;
}

extension SocialSignInProviderExtension on SocialSignInProvider {
  String getSocialImagePath() {
    switch (this) {
      case SocialSignInProvider.google:
        return 'utils/assets/images/google-icon.png';
      case SocialSignInProvider.facebook:
        return 'utils/assets/images/facebook-icon.png';
      case SocialSignInProvider.apple:
        return 'utils/assets/images/apple-icon.png';
    }
  }
}
