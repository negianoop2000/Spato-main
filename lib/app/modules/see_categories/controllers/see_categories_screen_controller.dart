import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/constants/api_service.dart';
import '../../../data/model/category_productList.dart';
import '../../../routes/app_pages.dart';

class SeeCategoriesController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  var categories = ["Pools", "Attraction", "Water Maintenance", "Pipe", "Technology"].obs;
  var apiCategories = ["POOLS", "ATTRAKTIONEN", "WASSERPFLEGE", "VERROHRUNG", "TECHNIK"].obs;
  var allProductList = <ProductList>[].obs;
  var imagescategori = [
    "assets/icons/pool_icon.jpg",
    "assets/icons/attractionicon.jpg",
    "assets/icons/water.jpg",
    "assets/icons/pipe.jpg",
    "assets/icons/technology.jpg",
  ].obs;
  RxList<bool> selectedCategories = [true, false, false, false, false].obs;  // Default selected categories
  var isStartSearch = false.obs;
  var products = <ProductList>[].obs;
  Timer? _debounce;

  var userName = ''.obs;
  var userEmail = ''.obs;
  var userImage = ''.obs;

  // Define selectedCategory
  var selectedCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    selectedCategory.value = apiCategories[0];  // Set default category to "POOLS"
    toggleCategory(0);  // Initialize with the first category
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }

  void toggleCategory(int index) {
    for (int i = 0; i < selectedCategories.length; i++) {
      selectedCategories[i] = i == index;
    }
    selectedCategories[index] = true;
    selectedCategory.value = apiCategories[index];
    productCategoriesApi(selectedCategory.value);
  }

  Future<void> productCategoriesApi(String category) async {
    print("Selected Category: $category");
    isLoading(true);
    try {
      var responseforuserid = await ApiService().fetchuserid(globalShopId);

      print(responseforuserid);

      String userid = responseforuserid['b2b_id'];
      var response = await ApiService().productCategories(category,userid);
      if (response != null) {
        var allProduct = response['allProduct'] as List<dynamic>? ?? [];

        allProductList.clear();
        allProductList.addAll(allProduct.map((data) => ProductList.fromJson(data)).toList());

        // Fetch images for products
        for (var product in allProductList) {
          if (product.bild1 != null) {
            await get_image(product.bild1!);
          }
        }

        // Update products list
        products.value = allProductList;

        update();
      }
    } catch (e) {
      print("Exception caught: $e");
    } finally {
      isLoading(false);
      print("isLoading set to false");
    }
  }


  Future<void> get_image(String imageBuild) async {
    try {
      var response = await ApiService().get_Image(imageBuild);

      if (response is Map<String, dynamic>) {
        if (response.containsKey('message') && response['message'] == "Image not found!") {
          print("Image not found. Using dummy asset image.");
          var dummyImageUrl = "assets/images/no-item-found.png";

          for (var product in allProductList) {
            if (product.bild1 == imageBuild) {
              product.imageUrl = dummyImageUrl;
            }
          }
        } else if (response.containsKey('url')) {
          var imageUrl = response['url'];

          for (var product in allProductList) {
            if (product.bild1 == imageBuild) {
              product.imageUrl = imageUrl;
            }
          }
        } else {
          print("Unexpected response format");
        }

        // Update the products list to reflect changes
        products.value = allProductList;
      } else {
        print("Response is not a valid Map");
      }
    } catch (e) {
      print("Exception caught: $e");
    }
  }

  Future<void> addToCartApi(String productid) async {
    isLoading(true);
    try {
      var response = await ApiService().addToCardApi(
        productid,
        1,
      );
      if (response['message'] == "Item added to cart successfully") {
        Get.snackbar('Success', response['message'], duration: Duration(seconds: 1));
        update();
      } else {
        //   Get.snackbar('Error', 'Added to cart unsuccessfully');
      }
    } finally {
      isLoading(false);
    }
  }

  String formatPrice(String price) {
    try {
      String normalizedPrice = price.replaceAll(',', '.');
      double? parsedPrice = double.tryParse(normalizedPrice);
      return parsedPrice != null ? parsedPrice.toStringAsFixed(2) : '0.00';
    } catch (e) {
      return '0.00';
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  void increment() => count.value++;
}

