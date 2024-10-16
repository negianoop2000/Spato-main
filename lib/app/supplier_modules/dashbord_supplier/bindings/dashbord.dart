import 'package:get/get.dart';
import 'package:spato_mobile_app/app/supplier_modules/dashbord_supplier/controllers/dashbord.dart';


class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
          () => DashboardController(),
    );
  }
}
