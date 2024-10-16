import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class needHelpController extends GetxController {
  // Reactive state variables
  var title = 'All Claim'.obs;

  var notes = <String>[].obs;
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
      var response = await ApiService().b2b_claimsListingApi();
      if (response != null && response['cliamList'] != null) {
        orders.assignAll(response['cliamList']); // Update this line
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
        return order['Claim_Nr']?.toLowerCase()?.contains(searchQuery.value.toLowerCase()) ??
            false || // Ensure each field is checked for null
                order['name']?.toLowerCase()?.contains(searchQuery.value.toLowerCase()) ??
            false ||
                order['Claimdatum']?.toLowerCase()?.contains(searchQuery.value.toLowerCase()) ??
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

  void updateTitle(String newTitle) {
    title.value = newTitle;
  }
}



