import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreenController extends GetxController {
  RxBool isNotificationEnabledAll = false.obs;
  var isNotificationEnabledPromotions = false.obs;
  var isNotificationEnabledOrders = false.obs;
  var isNotificationEnabledAlerts = false.obs;

  @override
  void onInit() {
    checkNotificationPermission();
    super.onInit();
  }

  // ✅ Check Notification Permission on App Start
  Future<void> checkNotificationPermission() async {
    PermissionStatus status = await Permission.notification.status;
    isNotificationEnabledAll.value = status.isGranted;
  }

  // ✅ Toggle Notifications when clicking the button
  Future<void> toggleNotificationAll() async {
    // if (newValue) {
    //   // User wants to enable notifications
    //   PermissionStatus status = await Permission.notification.request();
    //   if (status.isGranted) {
    //     isNotificationEnabledAll.value = true; // Update UI
    //   } else {
    //     openAppSettings();
    //    // isNotificationEnabledAll.value = false;
    //    // Get.snackbar("Permission Denied", "Enable notifications from settings.");
    //   }
    // } else {
    //   // User wants to disable notifications
    //   openAppSettings(); // Redirect to settings
    // }
    openAppSettings();
    PermissionStatus status = await Permission.notification.status;
    isNotificationEnabledAll.value = status.isGranted; // Updates UI

  }

  // ✅ Toggle Individual Notifications
  void toggleNotificationPromotions(bool newValue) {
    isNotificationEnabledPromotions.value = newValue;
  }

  void toggleNotificationOrders(bool newValue) {
    isNotificationEnabledOrders.value = newValue;
  }

  void toggleNotificationAlerts(bool newValue) {
    isNotificationEnabledAlerts.value = newValue;
  }
}
