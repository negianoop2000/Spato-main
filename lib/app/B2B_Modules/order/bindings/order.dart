import 'package:get/get.dart';
import 'package:spato_mobile_app/app/B2B_Modules/order/controllers/order.dart';



class orderB2BBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<orderB2BController>(
          () => orderB2BController(),
    );
  }
}
