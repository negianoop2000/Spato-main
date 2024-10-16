import 'package:get/get.dart';

import '../controllers/notification_list_screen_controller.dart';

class NotificationListScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationListScreenController>(
      () => NotificationListScreenController(),
    );
  }
}
