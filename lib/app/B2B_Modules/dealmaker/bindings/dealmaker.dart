import 'package:get/get.dart';
import 'package:spato_mobile_app/app/B2B_Modules/dealmaker/controllers/dealmaker.dart';



class dealmakerB2BBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<dealmakerB2BController>(
          () => dealmakerB2BController(),
    );
  }
}
