import 'package:get/get.dart';

import '../controllers/contactus_screen_controller.dart';

class ContactusScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactusScreenController>(
      () => ContactusScreenController(),
    );
  }
}
