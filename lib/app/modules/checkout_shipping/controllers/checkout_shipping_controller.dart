import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/app/data/model/address.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';

class CheckoutShippingController extends GetxController {
  var isLoading = false.obs;
  RxList<String> addresses = <String>[].obs;
  RxInt selectedAddressId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    addressListFetched();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> addressListFetched() async {
    try {
      isLoading(true);
      var response = await ApiService().getAllAddressList();
      if (response != null) {
        List permanentAddresses = response['Permanent_address'];
        List userTempAddresses = response['userTempAddsress'];

        addresses.assignAll([
          ...permanentAddresses.map((address) => formatAddress(address)).toList(),
          ...userTempAddresses.map((address) => formatAddress(address)).toList()
        ]);

        if (permanentAddresses.isNotEmpty) {
          selectedAddressId.value = 0;
        }

      } else {
    //    Get.snackbar('Error', 'Address fetch unsuccessful.', duration: Duration(seconds: 1));
      }
    } catch (e) {
   //   Get.snackbar('Error', 'An error occurred.', duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }

  String formatAddress(Map<String, dynamic> address) {
    return "${address['permanent_address']}, ${address['city']}, ${address['zipCode']}, ${address['country']}";
  }

  void selectAddress(int? id) {
    selectedAddressId.value = id ?? 0;
  }

  void printAddressesAndSelectedId() {
    print('Selected Address ID: ${selectedAddressId.value}');
    print('Addresses:');
    for (var address in addresses) {
      print(address);
    }
  }
  Future<void> addOrderApi() async {
    print("add order api calling data");
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retrieve stored values
      double subtotal = prefs.getDouble('subtotal') ?? 0.0;
      double tax = prefs.getDouble('tax') ?? 0.0;
      double orderTotal = prefs.getDouble('orderTotal') ?? 0.0;
      double discountedTotal = prefs.getDouble('discountedTotal') ?? 0.0;
      String selectedAddress = addresses[selectedAddressId.value];
      String userId = prefs.getString('userID') ?? "";
      String coupon_Code = prefs.getString('couponCode') ?? "";

      // Retrieve and convert stored lists
      List<String> productIdsString = prefs.getStringList('productIds') ?? [];
      List<String> productQuantitiesString = prefs.getStringList('productQuantities') ?? [];
      List<String> productPricesString = prefs.getStringList('productPrices') ?? [];

      // Convert to required types
      List<int> productIds = productIdsString.map((id) => int.tryParse(id) ?? 0).toList();
      List<double> productPrices = productPricesString.map((price) => double.tryParse(price) ?? 0.0).toList();
      List<int> productQuantities = productQuantitiesString.map((quantity) => int.tryParse(quantity) ?? 0).toList();

      // For testing purposes
      print("Selected Address: $selectedAddress");
      print("Product IDs: $productIds");
      print("Product Prices: $productPrices");
      print("Product Quantities: $productQuantities");
      print("userId $userId");
      print("coupon_Code $coupon_Code");

      // Call the API
      var response = await ApiService().OrderApi(
          selectedAddress,
          productIds,
          productPrices,
          productQuantities,
          coupon_Code,
          subtotal,
          0.0,
          tax,
          userId
      );

      print('add Order response: $response');
      if (response != null) {

        String responseMessage = response['message'] ?? 'Order added successfully';

        Get.snackbar('Success', responseMessage, duration: Duration(seconds: 1));

        await prefs.setString('orderID', response['order_id']);
        // clearCartApi();
        Get.offNamed(Routes.CHECKOUT_CONGRATULATION);

      } else {
        Get.snackbar('Error', response['error'] ?? 'Order added error');
      }
    } catch (e) {
    //  Get.snackbar('Error', 'Error while adding order');
    } finally {
      isLoading(false);
    }
  }

}





