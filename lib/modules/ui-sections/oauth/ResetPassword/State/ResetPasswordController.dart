import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  var isValidPassword = false.obs;
  var isValidEmail = false.obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    newPasswordController.addListener(_validatePassword);
    confirmPasswordController.addListener(_validatePassword);
    emailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _validatePassword() {
    String newPassword = newPasswordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    if (newPassword.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        _isValidPassword(newPassword) &&
        _isValidPassword(confirmPassword) &&
        newPassword == confirmPassword) {
      isValidPassword.value = true;
    } else {
      isValidPassword.value = false;
    }
  }

  bool _isValidPassword(String password) {
    return password.length > 6;
  }

  void _validateEmail() {
    String email = emailController.text.trim();
    if (email.isNotEmpty && _isValidEmail(email)) {
      isValidEmail.value = true;
    } else {
      isValidEmail.value = false;
    }
  }

  bool _isValidEmail(String email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }
}
