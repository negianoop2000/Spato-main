import 'package:get/get.dart';
import 'package:spato_mobile_app/app/modules/allReview/controllers/all_review_controller.dart';



class AllReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllReviewController>(
      () => AllReviewController(),
    );
  }
}
