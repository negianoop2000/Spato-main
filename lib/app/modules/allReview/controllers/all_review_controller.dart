import 'package:get/get.dart';
import 'package:spato_mobile_app/app/data/model/category_productList.dart';
import 'package:spato_mobile_app/app/data/model/products_list.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';

class AllReviewController extends GetxController {
  var reviews = <Review_List>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

