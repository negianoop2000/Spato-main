import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/common/bottomNavigationTap.dart';
import 'package:spato_mobile_app/utils/constants/ShowToast.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var rememberMe = false.obs;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  var hasEmailFocus = false.obs;
  var hasPassFocus = false.obs;
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  @override
  void onInit() async{
    super.onInit();
    emailFocusNode = FocusNode();
    emailFocusNode.addListener(handleFocusChange);
    passwordFocusNode = FocusNode();
    passwordFocusNode.addListener(handleFocusChange);
    emailController.addListener(handleTextChange);
    passwordController.addListener(handleTextChange);
    _loadRememberedCredentials();
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    print(authToken);
  }

  @override
  void onClose() {
    emailFocusNode.removeListener(handleFocusChange);
    emailFocusNode.dispose();
    passwordFocusNode.removeListener(handleFocusChange);
    passwordFocusNode.dispose();
    emailController.removeListener(handleTextChange);
    emailController.dispose();
    passwordController.removeListener(handleTextChange);
    passwordController.dispose();
    super.onClose();
  }

  void handleFocusChange() {
    hasEmailFocus.value = emailFocusNode.hasFocus;
    hasPassFocus.value = passwordFocusNode.hasFocus;
  }

  void handleTextChange() {
    if (rememberMe.value) {
      rememberMe.value = false;
      _removeCredentialsFromPreferences();
    }
    update();
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
    if (rememberMe.value) {
      _saveCredentialsToPreferences();
    } else {
      _removeCredentialsFromPreferences();
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void validation(BuildContext context) {
    // Trim leading and trailing spaces from email
    String trimmedEmail = emailController.text.trim();
    String password = passwordController.text;

    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp emailRegExp = RegExp(emailPattern);

    if (trimmedEmail.isEmpty) {
      Get.snackbar('Error', 'Please enter an email address', duration: Duration(seconds: 1));
    } else if (!emailRegExp.hasMatch(trimmedEmail)) {
      Get.snackbar('Error', 'Please enter a valid email address', duration: Duration(seconds: 1));
    } else if (password.isEmpty) {
      Get.snackbar('Error', 'Please enter your password', duration: Duration(seconds: 1));
    } else {
      // Call the signInApi method with the trimmed email
      signInApi(context, trimmedEmail, password);
    }
  }


  Future<void> signInApi(BuildContext context, String email, String password) async {
    try {
      isLoading(true);

      // Proceed with the API call using the trimmed email
      var response = await ApiService().loginApi(
        email,
        password,
      );
      print('response-----$response');

      if (response['status'] == 1 && response['success'] == "Login Successfull") {
        Get.snackbar('Success', response['success'], duration: Duration(seconds: 1));
        await setPreferencesAndNavigate(response);
        print("Navigating to BottomNavigationTap...");
        Get.offAll(() => BottomNavigationTap());
      } else if (response['status'] == 3 && response['error'] != null) {
        Get.snackbar('Error', response['error'][0], duration: Duration(seconds: 3));
      } else if (response['status'] == 2 && response['error'] != null) {
        Get.snackbar('Error', response['error'][0], duration: Duration(seconds: 3));
      } else if (response['status'] == 4 && response['error'] != null) {
        Get.snackbar('Error', response['error'][0], duration: Duration(seconds: 3));
      }
      else {
        // Get.snackbar('Error', 'An unknown error occurred', duration: Duration(seconds: 1));
      }
    } catch (e) {
      // Get.snackbar('Error', 'An error occurred: $e', duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }


  Future<void> setPreferencesAndNavigate(Map<String, dynamic> response) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', response['token']);
    await prefs.setString('role', response['role']);
    print(response['token']);
    
  }

  Future<void> _saveCredentialsToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('remembered_email', emailController.text);
    await prefs.setString('remembered_password', passwordController.text);
  }

  Future<void> _removeCredentialsFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('remembered_email');
    await prefs.remove('remembered_password');
  }

  Future<void> _loadRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    String? rememberedEmail = prefs.getString('remembered_email');
    String? rememberedPassword = prefs.getString('remembered_password');
    if (rememberedEmail != null && rememberedPassword != null) {
      emailController.text = rememberedEmail;
      passwordController.text = rememberedPassword;
      rememberMe.value = true;
      print('Remembered email: $rememberedEmail, password: $rememberedPassword');
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  void increment() => count.value++;
}
