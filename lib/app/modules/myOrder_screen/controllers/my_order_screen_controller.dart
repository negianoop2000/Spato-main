import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/app/modules/myOrder_screen/views/B2C_orderView.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';

import '../views/SparePartDetail.dart';

class MyOrderScreenController extends GetxController with SingleGetTickerProviderMixin {
  final count = 0.obs;
  var isLoading = false.obs;
  var orders = [].obs;
  var sparePartOrders = [].obs;
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);
    super.onInit();
    showOrderHistory();
    showSparePartHistory();
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: TColors.primaryBackground,
      content: Center(child: Text(message, style: TextStyle(color: TColors.textRed))),
    ));
  }

  Future<void> showOrderHistory() async {
    try {
      isLoading(true);

      var response = await ApiService().orderHistory();
      if (response != null ) {
        orders.assignAll(response['orders']);
      } else {
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }
  Future<void> showSparePartHistory() async {
    try {
      isLoading(true);
      var response = await ApiService().showSparePartHistory();
      if (response != null ) {
        sparePartOrders.assignAll(response['orders']);
      } else {
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  void navigateToDetailView(String OrderID, String ordernumber) async {
    try {
      isLoading(true);
      var response = await ApiService().B2cgetOrdersDetails(OrderID);
      if (response != null && response['ordersDtl'] != null) {
        final result = await Get.to(() => DetailOrder_b2c_View(orderDetails: response,ordernumber:ordernumber));

        if (result == true) {
          showSparePartHistory();
          showOrderHistory();
        }
      } else {
        showSnackBar(Get.context!, "No order details found.");
      }
    } catch (e) {
      print("Error: $e");
      showSnackBar(Get.context!, "An error occurred");
    } finally {
      isLoading(false);
    }
  }

  void navigateToSparePartDetailView(String OrderID, String orderNumber) async {
    try {
      isLoading(true);
      var response = await ApiService().getSparePartDetails(OrderID);

      if (response != null && response['ordersDtl'] != null) {
        final result = await Get.to(() => SparepartDetail(orderDetails: response,orderNumber: orderNumber,));

        if (result == true) {
          showSparePartHistory();
          showOrderHistory();
        }
      } else {
        showSnackBar(Get.context!, "No order details found.");
      }
    } catch (e) {
      showSnackBar(Get.context!, "An error occurred");
    } finally {
      isLoading(false);
    }
  }



  Future<String> get_image(String imageBuild) async {
    isLoading(true);
    try {
      var response = await ApiService().get_Image(imageBuild);

      if (response is Map<String, dynamic>) {
        if (response.containsKey('url')) {
          return response['url'];
        } else if (response.containsKey('message') && response['message'] == "Image not found!") {
          return "assets/images/no-item-found.png";
        }
      }
      isLoading(false);
      return "assets/images/no-item-found.png";
    } catch (e) {
      isLoading(false);
      print("Exception caught: $e");
      return "assets/images/no-item-found.png";
    }
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}

