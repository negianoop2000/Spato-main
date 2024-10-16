import 'package:get/get.dart';
import 'package:spato_mobile_app/app/B2B_Modules/dashbord/controllers/dashbord.dart';



class DashboardB2BBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardB2BController>(
          () => DashboardB2BController(),
    );
  }
}
