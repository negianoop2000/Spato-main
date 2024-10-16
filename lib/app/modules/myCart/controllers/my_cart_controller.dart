import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/app/data/model/product_wishlist.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCartController extends GetxController {
  final count = 1.obs;
  var isLoading = false.obs;
  var couponCodeController = TextEditingController().obs;
  var userName = ''.obs;
  var userID = ''.obs;
  var userImage = ''.obs;
  var isCouponApplied = false.obs;
  RxList<ProductWishList1> productsClaim = <ProductWishList1>[].obs;

  var subtotal = 0.0.obs;
  var tax = 0.0.obs;
  var orderTotal = 0.0.obs;
  var discountedTotal = 0.0.obs;
  double discountAmount = 0.0;
  var isCartEmpty = false.obs;

  // Helper function to parse price strings
  double parsePrice(String price) {
    try {
      // Replace comma with dot and parse to double
      return double.parse(price.replaceAll(',', '.'));
    } catch (e) {
      print('Error parsing price: $price');
      return 0.0; // Return default value in case of error
    }
  }

  void incrementCount(int index) {
    productsClaim[index].count++;
    calculateSubtotal();
    productsClaim.refresh();  // Refresh the list to notify listeners
  }

  void decrementCount(int index) {
    if (productsClaim[index].count > 1) {
      productsClaim[index].count--;
    }
    calculateSubtotal();
    productsClaim.refresh();  // Refresh the list to notify listeners
  }

  void calculateSubtotal() {
    double total = 0.0;
    for (var product in productsClaim) {
      total += parsePrice(product.price) * product.count;  // Use `count` directly
    }
    subtotal.value = total;
    updateOrderTotal();
  }
  void updateOrderTotal() {
    double taxPercentage = 0.0; // Hardcoded 0% tax
    tax.value = subtotal.value * taxPercentage;
    orderTotal.value = subtotal.value + tax.value;
    discountedTotal.value = orderTotal.value - discountAmount;
    // savePreferences();
  }

  @override
  void onInit() {
    super.onInit();
    print("=============   My cart =============");
    initilize();
  }

  void initilize(){
    print("My cart     hsdhfvadsh ===  \''fgbf'fsg ++++++++++++++++-------  ");
    getCartItemsApi();
    profileUserApi();
  }

  Future<void> profileUserApi() async {
    print("Fetching profile data");
    try {
      isLoading(true);
      var response = await ApiService().profileUser();
      if (response != null ) {
        var userData = response['success'];
        userName.value = response['userName'] ?? 'No Name';
        userID.value = response['id'] ?? '1';
        userImage.value = userData['profile_picture'] ?? 'profile_pitcher';
        update();
        isLoading(false);

      } else {
        isLoading(false);
        Get.snackbar('Error', "An error update");
        update();
      }
    } catch (e) {
      isLoading(false);
      print('Error fetching profile data: $e');
      Get.snackbar('Error', "An error update");
      update();
    }
  }

  @override
  void onClose() {
    couponCodeController.value.dispose();
    super.onClose();
  }

  Future<void> getCartItemsApi() async {
    try {
      isLoading(true);
      var response = await ApiService().getCartItemsApi();
      if (response != null && response['cartItems'] != null) {
        var cartItems = response['cartItems'];
        print("Cart response: $cartItems");
        if (cartItems.isNotEmpty) {
          productsClaim.value = cartItems.map<ProductWishList1>((item) {
            print("Processing item: $item");
            return ProductWishList1(
              image: item['product_image'] ?? 'default_image_path',
              title: item['product_name'] ?? '',
              subtitle: item['Hersteller'] ?? '',
              price: item['Preis_zzgl_MwSt'] ?? '0.0',
              id: item['product_id'] ?? 0,
              count: item['quantity'] ?? 1,
            );
          }).toList();

          for (var product in productsClaim) {
            if (product.image.isNotEmpty) {
              product.imageUrl = await get_image(product.image);
              print("Image URL for ${product.title}: ${product.imageUrl}");
            }
          }

          calculateSubtotal();
          isCartEmpty.value = productsClaim.isEmpty;
        } else {
          isCartEmpty.value = true;
        }
      } else {
        isCartEmpty.value = true;
      }
    } catch (e) {
      print('Error: $e');
      isCartEmpty.value = true;
    } finally {
      isLoading(false);
    }
  }

  Future<String> get_image(String imageBuild) async {
    isLoading(true);
    try {
      var response = await ApiService().get_Image(imageBuild);

      if (response is Map<String, dynamic>) {
        if (response.containsKey('url')) {
          return response['url'];
        } else if (response.containsKey('message') && response['message'] == "Image not found!") {
          return "assets/images/no-item-found.png"; // Return a default image URL
        }
      }
      isLoading(false);
      return "assets/images/no-item-found.png"; // Fallback to a default image URL
    } catch (e) {
      isLoading(false);
      print("Exception caught: $e");
      return "assets/images/no-item-found.png"; // Fallback to a default image URL on error
    }
  }

  Future<void> deleteItem(String productId) async {
    try {
      isLoading(true);
      var response = await ApiService().deleteCartItem(productId);
      print("Delete response: $response");
      if (response != null && response['message'] == 'Item removed successfully') {

        productsClaim.removeWhere((item) => item.id == productId);

        calculateSubtotal();
        productsClaim.refresh();
        await getCartItemsApi();
        Get.snackbar('Success', response['message'], duration: Duration(seconds: 1));
      } else {
        //    Get.snackbar('Error', 'Item delete unsuccessful.', duration: Duration(seconds: 1));
      }
    } catch (e) {
      //    Get.snackbar('Error', 'An error occurred.', duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }

  Future<void> checkOut() async {
    try {
      isLoading(true);
      var response = await ApiService().checkOutApi();
      if (response != null) {
        Get.snackbar('Success', 'Checkout successful.', duration: Duration(seconds: 1));
        productsClaim.refresh();
      } else {
        //     Get.snackbar('Error', 'Checkout unsuccessful.', duration: Duration(seconds: 1));
      }
    } catch (e) {
      //    Get.snackbar('Error', 'An error occurred.', duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }

  // Future<void> couponCode(String applyDiscCode, double originalSummaryTotal) async {
  //   try {
  //     isLoading(true);
  //     var response = await ApiService().applyDiscCodeApi(applyDiscCode, originalSummaryTotal);
  //     if (response != null && response['message'] != null) {
  //      // Get.snackbar('Success', response['message'], duration: Duration(seconds: 1));
  //
  //       if (response['coupon'] != null) {
  //         var coupon = response['coupon'];
  //         if (coupon['Typ'] == '%' && coupon['Rate'] != null) {
  //           double discountRate = double.parse(coupon['Rate']);
  //           discountAmount = (orderTotal.value * discountRate) / 100;
  //         } else if (coupon['Typ'] == '€' && coupon['Rate'] != null) {
  //           discountAmount = double.parse(coupon['Rate']);
  //         }
  //         updateOrderTotal();
  //         isCouponApplied.value = true;
  //       }
  //     } else {
  //     //  Get.snackbar('Error', response!['errors'] ?? 'Invalid coupon', duration: Duration(seconds: 1));
  //     }
  //   } catch (e) {
  //     //    Get.snackbar('Error', 'An error occurred.', duration: Duration(seconds: 1));
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  Future<void> couponCode(String applyDiscCode, double originalSummaryTotal) async {
    try {
      isLoading(true);

      // Check if coupon code is empty
      if (applyDiscCode.isEmpty) {
        // Clear coupon code and reset discount amount
        discountAmount = 0.0;
        isCouponApplied.value = false;
        updateOrderTotal(); // Recalculate totals without discount
        isLoading(false);
        return;
      }

      var response = await ApiService().applyDiscCodeApi(applyDiscCode, originalSummaryTotal);
      if (response != null && response['message'] != null) {
        if (response['coupon'] != null) {
          var coupon = response['coupon'];
          if (coupon['Typ'] == '%' && coupon['Rate'] != null) {
            double discountRate = double.parse(coupon['Rate']);
            discountAmount = (orderTotal.value * discountRate) / 100;
          } else if (coupon['Typ'] == '€' && coupon['Rate'] != null) {
            discountAmount = double.parse(coupon['Rate']);
          }
          isCouponApplied.value = true;
        }
      } else {
        // Reset discount if the coupon is invalid
        discountAmount = 0.0;
        isCouponApplied.value = false;
      }
      updateOrderTotal(); // Recalculate totals with or without discount
    } catch (e) {
      // Handle exceptions and reset discount
      discountAmount = 0.0;
      isCouponApplied.value = false;
    } finally {
      isLoading(false);
    }
  }




  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('subtotal', subtotal.value);
    await prefs.setDouble('tax', tax.value);
    await prefs.setDouble('orderTotal', orderTotal.value);
    await prefs.setDouble('discountedTotal', discountedTotal.value);
    await prefs.setString('userID', userID.value);
    await prefs.setBool('isCouponApplied', isCouponApplied.value);
    await prefs.setString('couponCode', couponCodeController.value.text);

    // Ensure the IDs are strings
    List<String> productIds = productsClaim.map((product) => product.id.toString()).toList();
    List<String> productQuantities = productsClaim.map((product) => product.count.toString()).toList();
    List<String> productPrices = productsClaim.map((product) => product.price).toList();

    await prefs.setStringList('productIds', productIds);
    await prefs.setStringList('productQuantities', productQuantities);
    await prefs.setStringList('productPrices', productPrices);

    print("Saved product details: IDs: $productIds, Quantities: $productQuantities, Prices: $productPrices");
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

}

class ProductWishList1 {
  String image;
  String title;
  String subtitle;
  String price;
  int id;
  int count;  // Remove `final` to make it mutable
  String imageUrl;

  ProductWishList1({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.id,
    required this.count,
    this.imageUrl = '',
  });
}

