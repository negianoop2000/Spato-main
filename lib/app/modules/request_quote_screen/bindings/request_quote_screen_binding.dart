import 'package:get/get.dart';

import '../controllers/request_quote_screen_controller.dart';

class RequestQuoteScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestQuoteScreenController>(
      () => RequestQuoteScreenController(),
    );
  }
}
