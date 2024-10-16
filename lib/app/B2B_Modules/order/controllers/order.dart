import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';

class orderB2BController extends GetxController {
  // Reactive state variables
  var title = 'All Orders'.obs;
  var isLoading = false.obs;
  var orders = [].obs;
  var searchQuery = ''.obs;

  TextEditingController requestController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    assignmentListing();
  }

  Future<void> assignmentListing() async {
    try {
      isLoading(true);
      var response = await ApiService().b2b_assignmentListing();
      if (response != null && response['assignments'] != null) {
        orders.assignAll(response['assignments']);
  //      Get.snackbar('Success', 'assignments data fetched successfully', duration: Duration(seconds: 1));
      } else {
  //      Get.snackbar('Error', 'Fetching assignments details failed', duration: Duration(seconds: 1));
      }
    } catch (e) {
 //     Get.snackbar('Error', 'An error occurred: $e', duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }

  Future<void> requestChange(String auftragsNr, String request) async {
    try {
      isLoading(true);
      var response = await ApiService().b2b_assignmentChangeForRequest(auftragsNr, request);
      print('Response: $response'); // Debugging line

      if (response != null && response['success'] != null) {
        Get.snackbar('Success', response['success'], duration: Duration(seconds: 1));

      } else {
  //      Get.snackbar('Error', 'Request Submission failed', duration: Duration(seconds: 1));
      }
    } catch (e) {
 //     Get.snackbar('Error', 'An error occurred: $e', duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }


  List<dynamic> get filteredOrders {
    if (searchQuery.isEmpty) {
      return orders;
    } else {
      return orders.where((order) {
        return order['Auftrags_Nr'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            order['status'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            order['Auftragsdatum'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            order['name'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            order['gesamt_netto'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            order['Ihre_Kundennummer'].toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}
