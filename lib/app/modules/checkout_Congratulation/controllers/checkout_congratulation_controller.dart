import 'package:get/get.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';

class CheckoutCongratulationController extends GetxController {
  final count = 0.obs;
  var subtotal = 0.0.obs;
  var tax = 0.0.obs;
  var orderTotal = 0.0.obs;
  var isLoading = false.obs;
  var OrderId = "".obs;
  var discount = 0.0.obs;
  var isCouponApplied = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadPreferences();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  // Method to load data from shared preferences
  Future<void> loadPreferences() async {
    isLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    subtotal.value = prefs.getDouble('subtotal') ?? 0.0;
    tax.value = prefs.getDouble('tax') ?? 0.0;
    orderTotal.value = prefs.getDouble('orderTotal') ?? 0.0;
    discount.value = prefs.getDouble('discountedTotal') ?? 0.0;
    OrderId.value = prefs.getString('orderID') ?? "";
    isCouponApplied.value = prefs.getBool("isCouponApplied") ?? false;
    print("is coupan apply in congratulation ${isCouponApplied.value}");
    isLoading(false);
  }
  // Method to remove data from shared preferences
  Future<void> clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('discountRate');
    await prefs.remove('discountAmount');
    await prefs.remove('newOrderTotal');
    await prefs.remove('subtotal');
    await prefs.remove('tax');
    await prefs.remove('orderTotal');
    await prefs.remove('orderID');
    await prefs.remove('orderTotal');
    await prefs.remove('discountedTotal');
    await prefs.remove('userID');
    await prefs.remove('productIds');
    await prefs.remove('productQuantities');
    await prefs.remove('productPrices');
    await prefs.remove('isCouponApplied');

    print("Cleared product details and user preferences.");
  }

  void onClearPreferencesButtonTapped() {
    clearPreferences();
    subtotal.value = 0.0;
    tax.value = 0.0;
    orderTotal.value = 0.0;
  }
}



