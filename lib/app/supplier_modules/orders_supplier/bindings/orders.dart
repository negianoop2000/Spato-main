import 'package:get/get.dart';
import 'package:spato_mobile_app/app/supplier_modules/orders_supplier/controllers/orders.dart';


class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(
          () => OrderController(),
    );
  }
}