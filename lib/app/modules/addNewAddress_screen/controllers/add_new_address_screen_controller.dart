import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewAddressScreenController extends GetxController {
  //TODO: Implement AddNewAddressScreenController

  final count = 0.obs;
  var areaController = TextEditingController().obs;
  var fullanmeController = TextEditingController().obs;
  var mobileController = TextEditingController().obs;
  var birthdayController = TextEditingController().obs;

  var isNotificationEnabled = false.obs;

  void toggleNotification(bool newValue) {
    isNotificationEnabled.value = newValue;
  }

  @override
  void onClose() {
    areaController.close();
    fullanmeController.close();
    mobileController.close();
    birthdayController.close();
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
