import 'package:get/get.dart';
import 'package:spato_mobile_app/app/supplier_modules/orders_supplier/views/supplier_orderView.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';

class OrderController extends GetxController {
  // Reactive state variables
  var title = 'Orders'.obs;
  var isLoading = false.obs;
  var orders = [].obs;
  var searchQuery = ''.obs;

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
    //    Get.snackbar('Success', 'assignments data fetched successfully', duration: Duration(seconds: 1));
      } else {
    //    Get.snackbar('Error', 'Fetching assignments details failed', duration: Duration(seconds: 1));
      }
    } catch (e) {
  //    Get.snackbar('Error', 'An error occurred: $e', duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }

  void navigateToDetailView(String assignmentID) async {
    try {
      isLoading(true);
      var response = await ApiService().b2b_getAssignmentDetails(assignmentID);
      print("Response: $response");
      if (response != null && response['assignmentDtl'] != null) {
        Get.to(() => DetailOrder_S_View(orderDetails: response));
      } else {
   //     Get.snackbar('Error', 'No details found for the selected deal.', duration: Duration(seconds: 1));
      }
    } catch (e) {
   //   Get.snackbar('Error', 'An error occurred: $e', duration: Duration(seconds: 1));
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
