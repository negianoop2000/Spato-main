import 'package:get/get.dart';

import '../controllers/policy_condition_controller.dart';

class PolicyConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PolicyConditionController>(
      () => PolicyConditionController(),
    );
  }
}
