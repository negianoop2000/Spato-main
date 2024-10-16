import 'package:get/get.dart';

import '../controllers/checkout_shipping_controller.dart';

class CheckoutShippingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutShippingController>(
      () => CheckoutShippingController(),
    );
  }
}
