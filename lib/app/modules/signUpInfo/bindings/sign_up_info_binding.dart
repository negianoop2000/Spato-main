import 'package:get/get.dart';

import '../controllers/sign_up_info_controller.dart';

class SignUpInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpInfoController>(
      () => SignUpInfoController(),
    );
  }
}
