import 'package:get/get.dart';

import '../controllers/forget_password_otp_screen_controller.dart';

class ForgetPasswordOtpScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPasswordOtpScreenController>(
      () => ForgetPasswordOtpScreenController(),
    );
  }
}
