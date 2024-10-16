import 'package:get/get.dart';

import '../controllers/all_category_controller.dart';

class AllcategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllcategoryController>(
      () => AllcategoryController(),
    );
  }
}
