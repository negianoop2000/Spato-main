import 'package:get/get.dart';

import 'legal_controller.dart';


class WordDocBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WordDocController>(() => WordDocController());
  }
}
