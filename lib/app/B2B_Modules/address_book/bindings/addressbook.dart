import 'package:get/get.dart';
import 'package:spato_mobile_app/app/B2B_Modules/address_book/controllers/addressbook.dart';




class AddressbookB2BBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressbookB2BController>(
          () => AddressbookB2BController(),
    );
  }
}
