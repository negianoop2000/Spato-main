import 'package:get/get.dart';

import '../controllers/address_book_screen_controller.dart';

class AddressBookScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressBookScreenController>(
      () => AddressBookScreenController(),
    );
  }
}
