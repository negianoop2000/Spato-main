import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/common/bottomNavigationTap.dart';
import 'package:spato_mobile_app/utils/Connectivity.dart';

import '../../../../utils/constants/api_service.dart';
class SplashController extends GetxController {
  // final ConnectivityService connectivityService = Get.find();
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    print("[SplashController] Initialized");
    // ever(connectivityService.isConnected, _handleConnectionStatus);
    _checkAuthToken();
  }

  void _handleConnectionStatus(bool isConnected) {
    print("[SplashController] Connection status: $isConnected");
    if (isConnected) {
      print("Connected");
     // _checkAuthToken();
    } else {
      //Get.snackbar('Error', 'Please connect to the internet', duration: Duration(seconds: 2));
    }
  }

  // void InitNotification(){
  //   PushNotification().requestPermission();
  //   PushNotification().getDeviceToken();
  //   PushNotification().initLocalNotification();
  //   PushNotification().openFromTerminateState();
  // }

  void _checkAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('auth_token');
    print("splash screen");
    print(authToken);
    print("Navigating to home screen in 3 seconds...");
    final role = prefs.getString('role');
    String? rememberedshopis = prefs.getString('remembered_shopid');
    if(rememberedshopis!=null){
      globalShopId = rememberedshopis;
    }
    Timer(Duration(seconds: 3), () {
      if (authToken != null) {

        print("Navigating to BottomNavigationTap...");
        Get.offAll(() => BottomNavigationTap());
        //Get.offAllNamed(Routes.INTRO_V_C);
      } else {
        print("Navigating to INTRO_V_C...");
        Get.offAllNamed(Routes.INTRO_V_C);
      }
    });
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

