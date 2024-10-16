import 'package:get/get.dart';
import 'package:spato_mobile_app/app/data/model/product_wishlist.dart';
import 'package:spato_mobile_app/app/modules/Offer_Role_screen/views/offer_detail.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';

class offer_RoleScreenController extends GetxController {
  //TODO: Implement WishlistScreenController

  var isLoading = false.obs;
  var orders = [].obs;


  @override
  void onInit() {
    super.onInit();
    showOrderHistory();
  }

  Future<void> showOrderHistory() async {
    try {
      isLoading(true);

      // Fetch the data from the API
      var response = await ApiService().b2b_offerListingApi();

      // Check if response is not null and contains 'offersGroupBy'
      if (response != null && response['offersGroupBy'] != null) {
        // Extract the 'offersGroupBy' list
        List<dynamic> offersGroupByDynamic = response['offersGroupBy'];

        // Convert the dynamic list to a list of maps
        List<Map<String, dynamic>> offersGroupByList = offersGroupByDynamic
            .map((item) => item as Map<String, dynamic>)
            .toList();

        // Update the orders list with the offersGroupByList
        orders.assignAll(offersGroupByList);

        Get.snackbar('Success', 'Offer data fetched successfully', duration: Duration(seconds: 1));
      } else {
        Get.snackbar('Error', 'Fetching offer details failed', duration: Duration(seconds: 1));
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e', duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }

  // Future<void> showOrderHistory() async {
  //     try {
  //       isLoading(true);
  //
  //       // Fetch the data from the API
  //       var response = await ApiService().b2b_offerListingApi();
  //
  //       // Check if response is not null and contains 'offersGroupBy'
  //       if (response != null && response['offersGroupBy'] != null) {
  //         // Extract the 'offersGroupBy' map
  //         Map<String, dynamic> offersGroupByMap = response['offersGroupBy'];
  //
  //         // Convert the map values to a list of maps
  //         List<Map<String, dynamic>> offersGroupByList = offersGroupByMap.values
  //             .map((item) => item as Map<String, dynamic>)
  //             .toList();
  //
  //         // Update the orders list with the offersGroupByList
  //         orders.assignAll(offersGroupByList);
  //
  //       //  Get.snackbar('Success', 'Offer data fetched successfully', duration: Duration(seconds: 1));
  //       } else {
  //       //  Get.snackbar('Error', 'Fetching offer details failed', duration: Duration(seconds: 1));
  //       }
  //     } catch (e) {
  //       print(e);
  //     //  Get.snackbar('Error', 'An error occurred: $e', duration: Duration(seconds: 1));
  //     } finally {
  //       isLoading(false);
  //     }
  //   }

  void navigateToDetailView(String offerNr) async {
    try {
      isLoading(true);
      var response = await ApiService().getOfferDetails(offerNr);
      if (response != null) {
        // Ensure the response is properly cast to the expected type
        List<dynamic> offersListDynamic = response['offersList'];

        // Convert the dynamic list to a list of maps
        List<Map<String, dynamic>> offersList = offersListDynamic
            .map((item) => item as Map<String, dynamic>)
            .toList();

        // Filter offers list to include only the items with the selected offer number
        var filteredOffersList = offersList
            .where((item) => item['Angebots_Nr'] == offerNr)
            .toList();

        Get.to(() => DetailOfferView(
          offersList: filteredOffersList,
        ));
      } else {
     //   Get.snackbar('Error', 'No details found for the selected offer.', duration: Duration(seconds: 1));
      }
    } catch (e) {
   //   Get.snackbar('Error', 'An error occurred: $e', duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }

  Future<void> statusChange(String code, String status) async {
    try {
      isLoading(true);
      var response = await ApiService().b2b_updateOfferStatusApi(code, status);
      print('Response: $response'); // Debugging line

      if (response != null && response['message'] != null) {
        Get.snackbar('Success', response['message'], duration: Duration(seconds: 1));
        await showOrderHistory();
      } else {
     //   Get.snackbar('Error', 'Request Submission failed', duration: Duration(seconds: 1));
      }
    } catch (e) {
   //   Get.snackbar('Error', 'An error occurred: $e', duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
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
}
