import 'package:get/get.dart';
import 'package:spato_mobile_app/app/supplier_modules/delivery_notes_supplier/controllers/delivery_notes.dart';


class DeliveryNotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryNotesController>(
          () => DeliveryNotesController(),
    );
  }
}