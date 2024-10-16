import 'package:get/get.dart';
import 'package:spato_mobile_app/app/supplier_modules/need_help_manager/controllers/needHelp_supplier.dart';



class needHelpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<needHelpController>(
          () => needHelpController(),
    );
  }
}
