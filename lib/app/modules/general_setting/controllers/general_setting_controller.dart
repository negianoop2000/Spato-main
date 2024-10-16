import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralSettingController extends GetxController {
  //TODO: Implement GeneralSettingController

  final count = 0.obs;
  bool isNotificationEnabled = false;
  TextEditingController nameController = TextEditingController();

  @override
  void onClose() {
    // Clean up the controller when it is disposed
    nameController.dispose();
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
