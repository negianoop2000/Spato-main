import 'package:get/get.dart';

import '../controllers/intro_v_c_controller.dart';

class IntroVCBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntroVCController>(
      () => IntroVCController(),
    );
  }
}
