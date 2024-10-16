import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';

class CreatePasswordController extends GetxController {
  //TODO: Implement CreatePasswordController

  final count = 0.obs;

  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var isRePasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  void toggleRePasswordVisibility() {
    isRePasswordVisible.value = !isRePasswordVisible.value;
  }

  validation(context) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp emailRegExp = RegExp(emailPattern);

    if (newPasswordController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your password',duration: Duration(seconds: 1));
    } else if (confirmPasswordController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter Re-Type password',duration: Duration(seconds: 1));
    } else if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords does not match',duration: Duration(seconds: 1));
    } else {

      // createPassword(context);
    }
  }



  // Future<void> createPassword(context) async {
  //   try {
  //     isLoading(true);
  //     var response = await ApiService().createPassword(
  //       newPasswordController.text,
  //       confirmPasswordController.text,
  //     );
  //     print('response-----$response');
  //     if (response['success'] == "Login Successfull") {
  //       showSnackBar(context, "${response['success']}");
  //       final prefs = await SharedPreferences.getInstance();
  //       await prefs.setString('auth_token', response['token']);
  //       print(response['token']);
  //       Get.offAll(() => BottomNavigationTap());
  //
  //       isLoading(false);
  //     } else if (response['status'] == false) {
  //       ToastClass.showToast('Login UnSuccessful');
  //       isLoading(false);
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void submit() {
    isLoading.value = true;
    // Add your password creation logic here
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
      Get.toNamed(Routes.LOGIN);
    });
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
