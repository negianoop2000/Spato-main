import 'package:get/get.dart';
import '../controllers/b2b_shop_admin.dart';

class B2BShopAdminBinding extends Bindings {
  @override
  void dependencies() {
    String userid = Get.parameters['userid'] ?? '';

    Get.lazyPut<B2bShopAdminController>(
          () => B2bShopAdminController(userid: userid),
    );
  }
}
