import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';

class ProfileScreenController extends GetxController {
  // Variables to hold user data
  var count = 0.obs;
  var isLoading = false.obs;
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userImage = ''.obs;
  var role = "".obs;
  var shopList = <Map<String, dynamic>>[].obs;
  @override
  void onInit() {
    super.onInit();
    setRole();
    print("Controller initialized");
    initilize();
  }
  void initilize() {
    print("My Profile //////// *********     hsdhfvadsh ==='fgbf'fsg ++++++++++++++++-------  ");
    profileUserApi();
  }

  void setRole() async {
    final prefs = await SharedPreferences.getInstance();
    role.value = prefs.getString('role') ?? '';
  }

  void navigateToEditProfile() async {
    var result = await Get.toNamed(Routes.EDIT_PROFILE);
    if (result == true) {
      // Refresh the screen or fetch the updated profile data
      profileUserApi();
    }
  }
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: TColors.primaryBackground,
      content: Center(
          child: Text(message, style: const TextStyle(color: TColors.textRed))),
    ));
  }


  Future<void> profileUserApi() async {
    print("Fetching profile data");
    try {
      isLoading(true);
      var response = await ApiService().profileUser();
      if (response != null ) {
        var userData = response['success'];
        userName.value = response['userName'] ?? 'No Name';
        userEmail.value = response['userEmail'] ?? 'No Email';
        userImage.value = userData['profile_picture'] ?? 'profile_pitcher';
        update();
        isLoading(false);

      } else {
        isLoading(false);
        showSnackBar(Get.context!, "Failed to fetch user data");
        update();
      }
    } catch (e) {
      isLoading(false);
      print('Error fetching profile data: $e');
      showSnackBar(Get.context!, "An error occurred");
      update();
    }
  }

  Future<void> removeLogoutPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('role');
    print("logot token");
    var authToken = prefs.getString('auth_token');
    print(authToken);

  }

  Future<void> _removeCredentialsFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('remembered_email');
    await prefs.remove('remembered_password');
  }


  Future<void> getb2blist() async {
    print("Fetching profile data");
    try {
      isLoading(true);
      var response = await ApiService().getb2bshoplist();
      if (response != null && response['shop_list'] != null) {
        shopList.assignAll(List<Map<String, dynamic>>.from(response['shop_list']));
        isLoading(false);
      } else {
        isLoading(false);
        showSnackBar(Get.context!, "Failed to fetch shops data");
      }
    } catch (e) {
      isLoading(false);
      showSnackBar(Get.context!, "An error occurred");
    }
  }

  Future<void> logoutUser() async {
    try {
      isLoading(true);
      var response = await ApiService().userLogoutApi();
      // if (response != null && response['status'] == 1) {
      if(response!=null){

        Get.snackbar('Success', response['message'] ?? 'Sign Out successful');
        await removeLogoutPreferences();
        Get.offNamed(Routes.LOGIN); // Navigate to login screen
      } else {
        isLoading(false);
        Get.snackbar('Error', response['message'] ?? 'Logout failed');
      }
    } catch (error) {
      isLoading(false);
      print('Error logging out: $error');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading(false);
    }
  }
  Future<void> deleteUser() async {
    try {
      isLoading(true);
      var response = await ApiService().userDeleteApi();
      if (response != null) {
        Get.snackbar('Success', response['success'] ?? 'Account Deleted');
        await removeLogoutPreferences();
        await _removeCredentialsFromPreferences();
        Get.offNamed(Routes.LOGIN);
      } else {
        isLoading(false);

      }
    } catch (error) {
      isLoading(false);
      print('Error logging out: $error');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading(false);
    }
  }





    void increment() => count.value++;
}
