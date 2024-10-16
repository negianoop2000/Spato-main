import 'package:get/get.dart';
import 'package:spato_mobile_app/app/B2B_Modules/bills/controllers/bills.dart';




class billsB2BBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<billsB2BController>(
          () => billsB2BController(),
    );
  }
}
