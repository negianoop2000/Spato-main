import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class billsB2BController extends GetxController {
  // Reactive state variables
  var title = 'All Bills'.obs;
  var isLoading = false.obs;
  var orders = [].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    showbilllisting();
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> showbilllisting() async {
    try {
      isLoading(true);
      var response = await ApiService().b2b_billsListing();
      if (response != null && response['billsNo'] != null) {
        orders.assignAll(response['billsNo']);
   //     Get.snackbar('Success', 'billsNo data fetched successfully', duration: Duration(seconds: 1));
      } else {
  //      Get.snackbar('Error', 'Fetching billsNo details failed', duration: Duration(seconds: 1));
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
        return order['Rechnungs_Nr'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            order['status'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            order['Rechnungsdatum'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
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
