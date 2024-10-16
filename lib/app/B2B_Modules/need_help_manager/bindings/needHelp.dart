import 'package:get/get.dart';
import 'package:spato_mobile_app/app/B2B_Modules/need_help_manager/controllers/needHelp.dart';




class needHelpB2BBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<needHelpB2BController>(
          () => needHelpB2BController(),
    );
  }
}
