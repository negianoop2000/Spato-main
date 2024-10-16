import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/common/bottomNavigationTap.dart';
import 'package:spato_mobile_app/utils/constants/ShowToast.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';

class SignUpController extends GetxController {
  var isLoading = false.obs;
  final count = 0.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypepasswordController = TextEditingController();
  RxBool agreeCheckBox = false.obs;
  var isPasswordVisible = false.obs;
  var isRePasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRePasswordVisibility() {
    isRePasswordVisible.value = !isRePasswordVisible.value;
  }

  void toggleAgreeToTerms() {
    agreeCheckBox.value = !agreeCheckBox.value;
  }

  validation(context) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp emailRegExp = RegExp(emailPattern);

    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
    } else if (!emailRegExp.hasMatch(emailController.text)) {
      Get.snackbar('Error', 'Please enter a valid email address');
    } else if (passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your password');
    } else if (retypepasswordController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter Re-Type password');
    } else if (passwordController.text != retypepasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match');
    } else if (!agreeCheckBox.value) {
      Get.snackbar('Error', 'You must agree to the Terms & Conditions of Policy');
    } else {
      Sign_up_Api(context);
    }
  }
  Future<void> Sign_up_Api(BuildContext context) async {
    try {
      isLoading(true);
      final prefs = await SharedPreferences.getInstance();
      final name = prefs.getString('user_name') ?? '';
      final phone = prefs.getString('phone_number') ?? '';
      final countrycode = prefs.getString('country_code') ?? '';
      final house_no = prefs.getString('house_no') ?? '';
      final role = prefs.getString('selected_role') ?? '';
      final street = prefs.getString('street') ?? '';
      final city = prefs.getString('city') ?? '';
      final country = prefs.getString('country') ?? '';
      final pincode = prefs.getString('pincode') ?? '';
      final company = prefs.getString('companyName') ?? '';
      final vat_ID = prefs.getString('vatID') ?? '';

      var response = await ApiService().signup(
        emailController.text,
        passwordController.text,
        retypepasswordController.text,
        role,
        name,
        countrycode,
        phone,
        street,
        pincode,
        city,
        house_no,
        country,
        agreeCheckBox.value,
        agreeCheckBox.value,
        company,
        vat_ID
      );

      print('response-----$response');
      if (response['success'] == "User registered successfully") {
        Get.snackbar('Success', response['success'],duration: Duration(seconds: 1));
        Get.toNamed(Routes.LOGIN);
      } else {
        // Handle validation errors
        if (response.containsKey('ValidationError')) {
          Map<String, dynamic> validationErrors = response['ValidationError'];
          String errorMessage = validationErrors.entries
              .map((e) => "${e.key}: ${e.value.join(', ')}")
              .join('\n');
          Get.snackbar('Error', errorMessage,duration: Duration(seconds: 1));
        } else {
         // Get.snackbar('Error', response['message'] ?? 'Sign up failed');
        }
      }
    } finally {
      isLoading(false);
    }
  }


  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    retypepasswordController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void increment() => count.value++;
}


//flutter build apk --target-platform=android-arm64