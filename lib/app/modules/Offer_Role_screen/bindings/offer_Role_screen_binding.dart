import 'package:get/get.dart';
import 'package:spato_mobile_app/app/modules/Offer_Role_screen/controllers/offer_Role_screen_controller.dart';


class offer_RoleScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<offer_RoleScreenController>(
      () => offer_RoleScreenController(),
    );
  }
}
