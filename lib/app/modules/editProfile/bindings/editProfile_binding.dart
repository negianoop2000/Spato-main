import 'package:get/get.dart';

import '../controllers/editProfile_controller.dart';

class editProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<editProfileController>(
      () => editProfileController(),
    );
  }
}
