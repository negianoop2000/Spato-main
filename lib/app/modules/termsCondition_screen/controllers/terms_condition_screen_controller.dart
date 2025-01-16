import 'package:get/get.dart';
import '../../../../utils/constants/api_service.dart';

class TermsConditionScreenController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  final RxString termsConditionsText = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchTermsConditions();
  }

  void fetchTermsConditions() async {
    isLoading.value = true;

    try {
      // Fetch user ID based on the globalShopId
      var responseForUserId = await ApiService().fetchuserid(globalShopId ?? "");
      print(responseForUserId);

      // Extract user ID
      String userid = responseForUserId['b2b_id'] ?? responseForUserId['userId'].toString();

      // Fetch privacy policy content
      var response = await ApiService().getprivacypolicies("TermsConditions", userid);
      print(response);

      // Check if the response contains the content field
      if (response != null && response['content'] != null) {
        termsConditionsText.value = response['content']['content'] ?? "No terms and conditions available.";
      } else {
        termsConditionsText.value = "Failed to load terms and conditions.";
      }
    } catch (e) {
      termsConditionsText.value = "An error occurred: $e";
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
