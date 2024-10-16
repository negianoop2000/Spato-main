import 'package:get/get.dart';
import 'package:spato_mobile_app/app/B2B_Modules/offer/controllers/offer.dart';



class offerB2BBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<offerB2BController>(
          () => offerB2BController(),
    );
  }
}
