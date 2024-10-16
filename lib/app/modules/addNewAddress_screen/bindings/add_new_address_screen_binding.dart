import 'package:get/get.dart';

import '../controllers/add_new_address_screen_controller.dart';

class AddNewAddressScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewAddressScreenController>(
      () => AddNewAddressScreenController(),
    );
  }
}
