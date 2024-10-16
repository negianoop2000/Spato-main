import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordOtpScreenController extends GetxController {
  //TODO: Implement ForgetPasswordOtpScreenController

  final count = 0.obs;

  final TextEditingController pinController = TextEditingController();
  bool showErrors = false;
  bool isCodeVerified = false;
  int timerSeconds = 60;
  Timer? _timer;
  String enteredPin = '';
  bool isResendButtonEnabled = true;
  bool _isLoading = false;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    pinController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (timerSeconds == 0) {
        _timer?.cancel();
      } else {
        timerSeconds--;
      }
      update();
    });
  }

  void restartTimer() {
    timerSeconds = 60;
    startTimer();
  }

  void verifyCode() {
    isCodeVerified = true;
    update();
  }


  @override
  void onReady() {
    super.onReady();
  }


  void increment() => count.value++;
}
