import 'package:get/get.dart';
import 'package:spato_mobile_app/app/B2B_Modules/credit_notes/controllers/creditNotes.dart';



class creditNotesB2BBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<creditNotesB2BController>(
          () => creditNotesB2BController(),
    );
  }
}
