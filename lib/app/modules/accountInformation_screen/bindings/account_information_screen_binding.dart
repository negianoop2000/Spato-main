import 'package:get/get.dart';

import '../controllers/account_information_screen_controller.dart';

class AccountInformationScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountInformationScreenController>(
      () => AccountInformationScreenController(),
    );
  }
}
