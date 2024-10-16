import 'package:get/get.dart';
import 'package:spato_mobile_app/app/B2B_Modules/dealmaker/detal_view.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';

class dealmakerB2BController extends GetxController {
  // Reactive state variables
  var title = 'All Deals'.obs;
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
      var response = await ApiService().b2b_dealListing();
      if (response != null && response['dealList'] != null) {
        orders.assignAll(response['dealList']);
   //     Get.snackbar('Success', 'creditList data fetched successfully', duration: Duration(seconds: 1));
      } else {
 //       Get.snackbar('Error', 'Fetching creditList details failed', duration: Duration(seconds: 1));
      }
    } catch (e) {
 //     Get.snackbar('Error', 'An error occurred: $e', duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }
  void navigateToDetailView(String dealNr) async {
    try {
      isLoading(true);
      var response = await ApiService().b2b_getDealDetailsByDealNr(dealNr);

      if (response != null) {
        // Extracting data from response
        var orderDetailsList = response['dealList'] as List<dynamic>?;
        var orderDetails = (orderDetailsList?.firstWhere(
              (item) => item['Deal_Nr'] == dealNr,
          orElse: () => null,
        )) ?? {};
        var b2cUserDetails = response['b2cUser'] ?? {};
        var b2bUserDetails = response['b2bUser'] ?? {};

        // Adjust these if the keys are not available in your response
        var productDetails = response['productDetails'] ?? [];
        var productPrices = response['productPrices'] ?? [];

        // Navigate to DetailView
        Get.to(() => DetailView(
          response: response, // Pass the entire response for flexibility
          b2cUserDetails: b2cUserDetails,
          b2bUserDetails: b2bUserDetails,
          // orderDetails: orderDetails,
          // productDetails: productDetails,
          // productPrices: productPrices,
        ));
      } else {
        Get.snackbar('Error', 'No details found for the selected deal.', duration: Duration(seconds: 1));
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e', duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }

  List<dynamic> get filteredOrders {
    if (searchQuery.isEmpty) {
      return orders;
    } else {
      return orders.where((order) {
        return order['Deal_Nr'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            order['Angebots_Nr'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            order['B2cName'].toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}
