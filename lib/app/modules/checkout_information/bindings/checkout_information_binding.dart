import 'package:get/get.dart';

import '../controllers/checkout_information_controller.dart';

class CheckoutInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutInformationController>(
      () => CheckoutInformationController(),
    );
  }
}
