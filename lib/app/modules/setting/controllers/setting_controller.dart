import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';

class SettingController extends GetxController {


  final count = 0.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> removeLogoutPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('role');
   // await prefs.remove('guest_token');
    //  await prefs.remove('remembered_password');
  }

  Future<void> _removeCredentialsFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('remembered_email');
    await prefs.remove('remembered_password');
  }

  Future<void> logoutUser() async {
    try {
      isLoading(true);
      var response = await ApiService().userLogoutApi();
    //  if (response != null && response['status'] == 1) {
      if(response!=null){
        Get.snackbar('Success', response['message'] ?? 'Sign Out successful');
        await removeLogoutPreferences();
        await _removeCredentialsFromPreferences();
        Get.offNamed(Routes.LOGIN); // Navigate to login screen
      } else {
        isLoading(false);
     //   Get.snackbar('Error', response['message'] ?? 'Logout failed');
      }
    } catch (error) {
      isLoading(false);
      print('Error logging out: $error');
   //   Get.snackbar('Error', 'An error occurred');
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
    @override
    void onReady() {
      super.onReady();
    }

    @override
    void onClose() {
      super.onClose();
    }

    void increment() => count.value++;

}
