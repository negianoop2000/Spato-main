import 'package:get/get.dart';

import '../controllers/checkout_congratulation_controller.dart';

class CheckoutCongratulationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutCongratulationController>(
      () => CheckoutCongratulationController(),
    );
  }
}
