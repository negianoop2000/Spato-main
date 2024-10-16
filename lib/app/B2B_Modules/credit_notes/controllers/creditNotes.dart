import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';

class creditNotesB2BController extends GetxController {
  // Reactive state variables
  var title = 'All Credits'.obs;
  var isLoading = false.obs;
  var orders = [].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    showOrderHistory();
  }

  Future<void> showOrderHistory() async {
    try {
      isLoading(true);
      var response = await ApiService().b2b_creditsListing();
      if (response != null && response['creditList'] != null) {
        orders.assignAll(response['creditList']);
  //      Get.snackbar('Success', 'creditList data fetched successfully', duration: Duration(seconds: 1));
      } else {
   //     Get.snackbar('Error', 'Fetching creditList details failed', duration: Duration(seconds: 1));
      }
    } catch (e) {
  //    Get.snackbar('Error', 'An error occurred: $e', duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }

  List<dynamic> get filteredOrders {
    if (searchQuery.isEmpty) {
      return orders;
    } else {
      return orders.where((order) {
        return order['Gutschrifts_Nr'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            order['status'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            order['Gutschriftsdatum'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
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


