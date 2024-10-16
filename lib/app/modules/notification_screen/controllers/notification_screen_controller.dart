import 'package:get/get.dart';

class NotificationScreenController extends GetxController {
  //TODO: Implement NotificationScreenController

  final count = 0.obs;
  var isNotificationEnabledAll = false.obs;
  var isNotificationEnabledPromotions = false.obs;
  var isNotificationEnabledOrders = false.obs;
  var isNotificationEnabledAlerts = false.obs;

  void toggleNotificationAll(bool newValue) {
    isNotificationEnabledAll.value = newValue;
  }

  void toggleNotificationPromotions(bool newValue) {
    isNotificationEnabledPromotions.value = newValue;
  }

  void toggleNotificationOrders(bool newValue) {
    isNotificationEnabledOrders.value = newValue;
  }

  void toggleNotificationAlerts(bool newValue) {
    isNotificationEnabledAlerts.value = newValue;
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
    super.onClose();
  }

  void increment() => count.value++;
}
