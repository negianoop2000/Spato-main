import 'package:get/get.dart';

import 'bottom_controller.dart';


class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationController>(() => BottomNavigationController());
  }
}
