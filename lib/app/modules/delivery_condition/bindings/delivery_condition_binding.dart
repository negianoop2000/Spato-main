import 'package:get/get.dart';
import 'package:spato_mobile_app/app/modules/delivery_condition/controllers/delivery_condition_controller.dart';



class DeliveryConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryConditionController>(
      () => DeliveryConditionController(),
    );
  }
}
