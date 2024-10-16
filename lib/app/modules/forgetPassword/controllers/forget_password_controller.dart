import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/ShowToast.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';

class ForgetPasswordController extends GetxController {
  //TODO: Implement ForgetPasswordController

  final count = 0.obs;
  var isLoading = false.obs;
  final TextEditingController emailController = TextEditingController();

  void validation(BuildContext context) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp emailRegExp = RegExp(emailPattern);

    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a email address',duration: Duration(seconds: 1));
    } else if (!emailRegExp.hasMatch(emailController.text)) {
      Get.snackbar('Error', 'Please enter a valid email address',duration: Duration(seconds: 1));
    } else {
      forgetPassApi(context);
    }
  }


  Future<void> forgetPassApi(BuildContext context) async {
    print("API called");
    try {
      isLoading(true);

      var response = await ApiService().forgetPassApi(
        emailController.text,
      );
      print('Response forgot-----$response');

      if (response != null) {
        if (response.containsKey('success')) {
          // Display success message
          Get.snackbar('Success', response['success'], duration: Duration(seconds: 1));
          Get.toNamed(Routes.LOGIN);
        } else if (response.containsKey('error')) {
          // Display error message
          Get.snackbar('Error', response['error'], duration: Duration(seconds: 1));
        } else if (response['status'] == false) {
          // Handle specific status-based errors, if applicable
          Get.snackbar('Error', 'Operation failed', duration: Duration(seconds: 1));
        }
      } else {
        Get.snackbar('Error', 'Unexpected error occurred', duration: Duration(seconds: 1));
      }
    } finally {
      isLoading(false);
    }
  }



  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
