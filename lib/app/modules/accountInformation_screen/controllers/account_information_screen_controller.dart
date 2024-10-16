import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';

class AccountInformationScreenController extends GetxController {
  //TODO: Implement AccountInformationScreenController

  final count = 0.obs;
  var isLoading = false.obs;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final birthdayController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    print("Controller initialized");
    profileUserApi();
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: TColors.primaryBackground,
      content: Center(child: Text(message, style: TextStyle(color: TColors.textRed))),
    ));
  }

  Future<void> profileUserApi() async {
    print("Fetching profile data");
    try {
      isLoading(true);
      var response = await ApiService().profileUser();
      print('Profile user response: $response');
      if (response != null ) {
        var userData = response['success'];
        nameController.text = response['userName'] ?? '';
        emailController.text = response['userEmail'] ?? '';
        isLoading(false);
      } else {
        isLoading(false);
      //  showSnackBar(Get.context!, "Failed to fetch user data");
      }
    } catch (e) {
      isLoading(false);
      print('Error fetching profile data: $e');
   //   showSnackBar(Get.context!, "An error occurred");
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    genderController.dispose();
    birthdayController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
