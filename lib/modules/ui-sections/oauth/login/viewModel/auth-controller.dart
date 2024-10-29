import 'package:flutter_ecommerce/modules/service/auth-service/auth-service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var email = "".obs;
  var password = "".obs;
  var confirmPassword = "".obs;
  var errorText = "".obs;
  final emailRegEx = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  void reset() {
    isLoading.value = false;
    email.value = "";
    password.value = "";
    confirmPassword.value = "";
    errorText.value = "";

    // isLoading = false.obs;
    // email = "".obs;
    // password = "".obs;
    // confirmPassword = "".obs;
    // errorText = "".obs;
  }

  bool get isValidEmailPass =>
      validateEmail(email.value) == null &&
      validatePassword(password.value) == null;

  bool get isValidPassConfirmPass =>
      validatePassword(password.value) == null &&
      validatePassword(confirmPassword.value) == null &&
      password.value == confirmPassword.value;

  bool get isValidEmailPassConfirmPass =>
      validateEmail(email.value) == null &&
      validatePassword(password.value) == null &&
      validatePassword(confirmPassword.value) == null &&
      password.value == confirmPassword.value;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!emailRegEx.hasMatch(value)) {
      return 'Invalid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<bool> loginWithEmail() async {
    if (!isValidEmailPass) {
      return false;
    }
    errorText.value = "";
    isLoading.value = true;
    try {
      await AuthService.shared.signInWithEmail(email.value, password.value);
      isLoading.value = false;
      return true;
    } catch (err) {
      errorText.value = err.toString();
      print("Error = ${err.toString()}");
    }
    isLoading.value = false;
    return false;
  }

  Future<bool> signup() async {
    if (!isValidEmailPassConfirmPass) {
      return false;
    }
    errorText.value = "";
    isLoading.value = true;
    try {
      await AuthService.shared.signupWithEmail(email.value, password.value);
      isLoading.value = false;
      return true;
    } catch (err) {
      errorText.value = err.toString();
      print("Error = ${err.toString()}");
    }
    isLoading.value = false;
    return false;
  }

  Future<bool> googleLogin() async {
    isLoading.value = true;
    errorText.value = "";
    try {
      await AuthService.shared.signInWithGoogle();
      isLoading.value = false;
      return true;
    } catch (err) {
      errorText.value = err.toString();
      print("Error google signin = ${err.toString()}");
    }
    isLoading.value = false;
    return false;
  }

  Future<bool> sendResetPasswordEmail(String email) async {
    isLoading.value = true;
    errorText.value = "";
    try {
      await AuthService.shared.sendResetPasswordEmail(email);
      isLoading.value = false;
      return true;
    } catch (err) {
      errorText.value = err.toString();
      print("Error sending password reset email = ${err.toString()}");
    }
    isLoading.value = false;
    return false;
  }

  Future<bool> updatePassword(String pass) async {
    isLoading.value = true;
    errorText.value = "";
    try {
      await AuthService.shared.updatePassword(pass);
      isLoading.value = false;
      return true;
    } catch (err) {
      errorText.value = err.toString();
      print("Error Updating password = ${err.toString()}");
    }
    return false;
  }

  Future<bool> logout() async {
    isLoading.value = true;
    errorText.value = "";
    try {
      await AuthService.shared.logout();
      isLoading.value = false;
      return true;
    } catch (err) {
      print("Error to logout = ${err.toString()}");
      errorText.value = err.toString();
    }
    return false;
  }
}
