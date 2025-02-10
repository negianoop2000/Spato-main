import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/app/data/model/address.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';

import '../../../../utils/constants/colors.dart';
import '../../order_summary/views/order_summary_view.dart';


class CheckoutShippingController extends GetxController {
  var isLoading = false.obs;
  RxList<String> addresses = <String>[].obs;
  RxInt selectedAddressId = 0.obs;
  late List<dynamic> cartitems;
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


  Future<void> checkOut(BuildContext context) async {
    try {
      isLoading(true);

      // Call the checkout API
      var response = await ApiService().checkOutApi();

      if (response != null) {
        cartitems = response['cartItems'] as List<dynamic>;


          // Process cart items
          if (cartitems.isNotEmpty) {
            // Initialize calculation variables
            double updatedSubtotal = 0.0;
            double updatedTax = 0.0;
            double updatedDiscountedTotal = 0.0;

            List<String> productIds = [];
            List<String> productQuantities = [];
            List<String> productPrices = [];

            // Process cart items
            for (var cartItem in cartitems) {
              double itemFinalRate = double.parse(cartItem['final_rate'].toString());
              int itemQuantity = int.parse(cartItem['quantity'].toString());
              double itemTaxRate = cartItem['tax'] != null && cartItem['tax'].toString().isNotEmpty
                  ? double.parse(cartItem['tax'].toString())
                  : 0.0;
              double itemDiscountRate = double.parse(cartItem['discount_percentage'].toString()) / 100.0;

              // Calculate subtotal, tax, and discounted total
              double itemTotal = itemFinalRate * itemQuantity;
              updatedSubtotal += itemTotal;
              updatedTax += itemTotal * itemTaxRate;
              updatedDiscountedTotal += itemTotal - (itemTotal * itemDiscountRate);

              // Collect product details
              productIds.add(cartItem['product_id'].toString());
              productQuantities.add(cartItem['quantity'].toString());
              productPrices.add(cartItem['final_rate'].toString());
            }

            double updatedOrderTotal = updatedSubtotal + updatedTax;

            // Call savePreferences with updated data
            await savePreferences(
              subtotal: updatedSubtotal,
              tax: updatedTax,
              orderTotal: updatedOrderTotal,
              discountedTotal: updatedDiscountedTotal,
              productIds: productIds,
              productQuantities: productQuantities,
              productPrices: productPrices,
            );

          //  showOrderSummaryDialog(context, cartitems);
            Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  OrderSummaryView(cartitems)),
            );
          }

        else {
          Get.snackbar('Info', 'No items in the cart.', duration: Duration(seconds: 1));
        }
      } else {
        Get.snackbar('Error', 'Checkout unsuccessful.', duration: Duration(seconds: 1));
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred during checkout.', duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }

  Future<void> savePreferences({required double subtotal, required double tax, required double orderTotal, required double discountedTotal, required List<String> productIds, required List<String> productQuantities, required List<String> productPrices,}) async {

    final prefs = await SharedPreferences.getInstance();

    // Save updated values
    await prefs.setDouble('subtotal', subtotal);
    await prefs.setDouble('tax', tax);
    await prefs.setDouble('orderTotal', orderTotal);
    await prefs.setDouble('discountedTotal', discountedTotal);

    // Save product details
    await prefs.setStringList('productIds', productIds);
    await prefs.setStringList('productQuantities', productQuantities);
    await prefs.setStringList('productPrices', productPrices);

    // Save user details and coupon data
  //  await prefs.setString('userID', userID.value);
   // await prefs.setBool('isCouponApplied', isCouponApplied.value);
   // await prefs.setString('couponCode', couponCodeController.value.text);

    // Debugging: print saved data
    print("Saved Preferences: Subtotal: $subtotal, Tax: $tax, Order Total: $orderTotal");
    print("Product IDs: $productIds, Quantities: $productQuantities, Prices: $productPrices");
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
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retrieve stored values
      double tax = prefs.getDouble('tax') ?? 0.0;
      String selectedAddress = addresses[selectedAddressId.value];
      String userId = prefs.getString('userID') ?? "";
      String couponCode = prefs.getString('couponCode') ?? "";

      // Retrieve the cart details
      List<int> productIds = [];
      List<int> productQuantities = [];
      List<double> productPrices = [];
      double totalPrice = 0.0; // Initialize subtotal

      for (var cartItem in cartitems) {
        productIds.add(cartItem['product_id']);
        productQuantities.add(cartItem['quantity']);

        double finalRate = double.parse(cartItem['final_rate'].toString());
        int quantity = int.tryParse(cartItem['quantity'].toString()) ?? 0;

        // Add the rate for the current item multiplied by its quantity to the total price
        totalPrice += finalRate * quantity;

        // Add product price for tracking purposes
        productPrices.add(finalRate);
      }

      // Call the API
      var response = await ApiService().OrderApi(
        selectedAddress,
        productIds,
        productPrices,
        productQuantities,
        couponCode,
        totalPrice,
        0.0,
        tax,
        userId,
      );

      if (response != null && response['message'] != null) {
        String responseMessage = response['message'];
        Get.snackbar('Success', responseMessage, duration: Duration(seconds: 1));

        await prefs.setString('orderID', response['order_id']);
        Get.offNamed(Routes.CHECKOUT_CONGRATULATION);
      } else {
        Get.snackbar('Error', response['error'] ?? 'Order addition failed.', duration: Duration(seconds: 1));
      }
    } catch (e) {
      Get.snackbar('Error', 'Error while adding order.', duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }
}





