import 'package:get/get.dart';

import '../controllers/spare_part_screen_controller.dart';

class SparePartScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SparePartScreenController>(
      () => SparePartScreenController(),
    );
  }
}
