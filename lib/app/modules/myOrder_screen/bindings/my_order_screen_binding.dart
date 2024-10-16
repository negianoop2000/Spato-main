import 'package:get/get.dart';

import '../controllers/my_order_screen_controller.dart';

class MyOrderScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyOrderScreenController>(
      () => MyOrderScreenController(),
    );
  }
}
