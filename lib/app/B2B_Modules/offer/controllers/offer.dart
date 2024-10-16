import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class offerB2BController extends GetxController {
  var title = 'All Offers'.obs;
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
      var response = await ApiService().b2b_offerListingApi();
      if (response != null && response['offersList'] != null) {
        orders.assignAll(response['offersList']);
 //       Get.snackbar('Success', 'Offer data fetched successfully', duration: Duration(seconds: 1));
      } else {
  //      Get.snackbar('Error', 'Fetching offer details failed', duration: Duration(seconds: 1));
      }
    } catch (e) {
  //    Get.snackbar('Error', 'An error occurred: $e', duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
  Future<void> launchInBrowserView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
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
 //       Get.snackbar('Error', 'Request Submission failed', duration: Duration(seconds: 1));
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
        return order['Angebots_Nr'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            order['status'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            order['Angebotsdatum'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
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


