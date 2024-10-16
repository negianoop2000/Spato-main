import 'package:get/get.dart';

import '../controllers/see_categories_screen_controller.dart';

class SeeCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeeCategoriesController>(
      () => SeeCategoriesController(),
    );
  }
}
