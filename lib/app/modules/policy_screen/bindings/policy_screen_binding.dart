import 'package:get/get.dart';

import '../controllers/policy_screen_controller.dart';

class PolicyScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PolicyScreenController>(
      () => PolicyScreenController(),
    );
  }
}
