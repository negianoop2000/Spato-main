import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryNotesController extends GetxController {
  // Reactive state variables
  var notes = <String>[].obs;
  var title = 'All delivery notes'.obs;
  var isLoading = false.obs;
  var orders = <dynamic>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    deliveryNotesListing();
  }

  Future<void> deliveryNotesListing() async {
    try {
      isLoading(true);
      var response = await ApiService().b2b_deliveryNotesListing();
      if (response != null && response['delivery_notes'] != null) {
        orders.assignAll(response['delivery_notes']); // Update this line
      } else {
        // Handle case where delivery_notes is null
      }
    } catch (e) {
      // Handle error
    } finally {
      isLoading(false);
    }
  }

  List<dynamic> get filteredOrders {
    if (searchQuery.isEmpty) {
      return orders;
    } else {
      return orders.where((order) {
        return order['Lieferschein_Nr']?.toLowerCase()?.contains(searchQuery.value.toLowerCase()) ??
            false || // Ensure each field is checked for null
                order['deliveryStatus']?.toLowerCase()?.contains(searchQuery.value.toLowerCase()) ??
            false ||
                order['Lieferdatum']?.toLowerCase()?.contains(searchQuery.value.toLowerCase()) ??
            false ||
                order['name']?.toLowerCase()?.contains(searchQuery.value.toLowerCase()) ??
            false ||
                order['Ihre_Kundennummer']?.toLowerCase()?.contains(searchQuery.value.toLowerCase()) ??
            false;
      }).toList();
    }
  }

  Future<void> launchURL() async {
    final url = ApiService.webUrl;
    print('Launching URL: $url');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar('Error', 'Could not launch URL');
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}
