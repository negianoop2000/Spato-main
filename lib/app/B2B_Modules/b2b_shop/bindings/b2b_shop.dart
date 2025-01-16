import 'package:get/get.dart';
import 'package:spato_mobile_app/app/B2B_Modules/b2b_shop/controllers/b2b_shop.dart';


class B2BShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<B2BShopController>(
          () => B2BShopController(),
    );
  }
}
