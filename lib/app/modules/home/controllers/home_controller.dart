import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/app/data/model/category_productList.dart';
import 'package:spato_mobile_app/app/data/model/products_list.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/ShowToast.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  var searchController = TextEditingController().obs;
  var categories = ["Pools", "Attraction", "Water Maintenance", "Pipe", "Technology"].obs;
  var apiCategories = ["POOLS", "ATTRAKTIONEN", "WASSERPFLEGE", "VERROHRUNG", "TECHNIK"].obs;
  var allProductList = <ProductList>[].obs;
  var bundleProductList = <ProductList>[].obs;
  var imagescategori = [
    "assets/icons/pool_icon.jpg",
    "assets/icons/attractionicon.jpg",
    "assets/icons/water.jpg",
    "assets/icons/pipe.jpg",
    "assets/icons/technology.jpg",
  ].obs;
  var selectedCategories = [false, false, false, false, false].obs;
  var isStartSearch = false.obs;
  var products = <ProductList>[].obs;
  var bundleproducts = <ProductList>[].obs;
  var searchResults = <ProductList>[].obs;
  Timer? _debounce;

  var userName = ''.obs;
  var userEmail = ''.obs;
  var userImage = ''.obs;
  var bannerImage = ''.obs;
  var bannerContained = ''.obs;
  var options = <String>[].obs;
  var selectedOptions = <String>[].obs;
  var selectedHerstNr = <String>[].obs;
  var supplierMap = <String, String>{}.obs; // To store Hersteller and Herst_Nr
  var isSelectedFiltered = false.obs;

  void toggleOption(String option) {
    if (selectedOptions.contains(option)) {
      selectedOptions.remove(option);
      selectedHerstNr.remove(supplierMap[option]); // Remove the corresponding Herst_Nr
    } else {
      selectedOptions.add(option);
      selectedHerstNr.add(supplierMap[option] ?? ''); // Add the corresponding Herst_Nr
    }
    isSelectedFiltered.value = selectedOptions.isNotEmpty;
  }

  Future<void> saveSelectedOptions() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selectedOptions', selectedOptions);
    await prefs.setStringList('selectedHerstNr', selectedHerstNr);
    print("Saved options: ${selectedOptions.join(', ')}");
    print("Saved Herst_Nr: ${selectedHerstNr.join(', ')}");
    Get.toNamed(Routes.ALL_CATEGORY);
  }

  void toggleCategory(int index) {
    for (int i = 0; i < selectedCategories.length; i++) {
      selectedCategories[i] = false;
    }
    selectedCategories[index] = true;
   // productCategoriesApi(apiCategories[index]);

  }

  @override
  void onInit() {
    super.onInit();
    print("=============   Home =============");
    initilize();
  }

  void initilize(){
    print("Home     hsdhfvadsh ===  \''fgbf'fsg ++++++++++++++++-------  ");
    searchController.value.addListener(_onSearchChanged);
    productCategoriesApi();
    profileUserApi();
    getsupplierData();
  }
  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchApi(searchController.value.text);
    });
  }

  @override
  void onClose() {
    searchController.value.removeListener(_onSearchChanged);
    _debounce?.cancel();
    super.onClose();
  }

  Future<void> profileUserApi() async {
    print("Fetching profile data");
    try {
      isLoading(true);
      var response = await ApiService().profileUser();
      if (response != null ) {
        var userData = response['success'];
        userName.value = response['userName'] ?? 'No Name';
        userImage.value = userData['profile_picture'] ?? 'profile_pitcher';
        update();
        isLoading(false);

      } else {
        isLoading(false);
        update();
      }
    } catch (e) {
      isLoading(false);
      print('Error fetching profile data: $e');
   //   Get.snackbar('Error', "An error update");
      update();
    }
  }


  // Method to fetch product categories and update product list
  Future<void> productCategoriesApi() async {
    isLoading(true);
    try {

      var responseforuserid = await ApiService().fetchuserid(globalShopId ?? "");

      print(responseforuserid);

      String userid = responseforuserid['b2b_id']?? responseforuserid['userId'].toString();
      var response = await ApiService().getAllLatestProductsHomeApi(userid);
      if (response != null) {
        var allProduct = response['latestProduct'] as List;

        var bundleproduct = response.containsKey('bundelProduct') && response['bundelProduct'] is List
            ? response['bundelProduct'] as List
            : [];



        allProductList.clear();
        bundleProductList.clear();
        allProductList.addAll(allProduct.map((data) => ProductList.fromJson(data)).toList());
        bundleProductList.addAll(bundleproduct.map((data) => ProductList.fromJson(data)).toList());


        var bannerData = response['banner'];

        if (bannerData is List && bannerData.isNotEmpty) {
          var banner = bannerData[0];
          bannerImage.value = banner['banner_image'] ?? '';
          bannerContained.value = banner['banner_content'] ?? '';
        } else {
          // Set default values if the banner data is missing
          bannerImage.value = '';
          bannerContained.value = '';
        }


        for (var product in allProductList) {
          if (product.bild1 != null) {
            await get_image(product.bild1!);
          }

        }

        // Update products list
        products.value = allProductList;
        bundleproducts.value = bundleProductList;
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
   // isLoading(true);
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
    } finally {
  //    isLoading(false);
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
        Get.snackbar('Success', response['message'],duration: Duration(seconds: 1));
        update();
      } else {
     //   Get.snackbar('Error', 'Added to cart unsuccessfully');
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> getsupplierData() async {
    isLoading(true);
    try {
      var response = await ApiService().getSupplierListHomeApi();
      if (response != null && response.containsKey('supplierList')) {
        // var supplierList = response['supplierList'] as Map<String, dynamic>;
        //
        // options.clear();
        // supplierMap.clear(); // Clear the map before adding new data
        //
        // supplierList.forEach((key, value) {
        //   if (value is Map<String, dynamic> && value.containsKey('Hersteller') && value.containsKey('Herst_Nr')) {
        //     String hersteller = value['Hersteller'];
        //     String herstNr = value['Herst_Nr'];
        //
        //     options.add(hersteller);
        //     supplierMap[hersteller] = herstNr; // Map Hersteller to Herst_Nr
        //   }
        // });

        var supplierList = response['supplierList'] as List<dynamic>;

        options.clear();
        supplierMap.clear(); // Clear the map before adding new data

        for (var supplier in supplierList) {
          if (supplier is Map<String, dynamic> &&
              supplier.containsKey('Hersteller') &&
              supplier.containsKey('Herst_Nr')) {
            String hersteller = supplier['Hersteller'];
            String herstNr = supplier['Herst_Nr'];

            options.add(hersteller);
            supplierMap[hersteller] = herstNr; // Map Hersteller to Herst_Nr
          }
        }




        options.refresh();
        update();
      }
    } catch (e) {
      print("Exception caught: $e");
    } finally {
      isLoading(false);
      print("isLoading set to false");
    }
  }


  Future<void> searchApi(String searchText) async {
  //  if (searchText.isEmpty) return;
    if (searchText.isEmpty) {
      searchResults.clear();
      isLoading.value = false;
      return;
    }
    isLoading(true);
    try {
      var response = await ApiService().searchApi(searchText);
      if (response != null && response is Map<String, dynamic> && response.containsKey('findProductName')) {
        var allProduct = response['findProductName'] as List<dynamic>? ?? [];
        searchResults.value = allProduct.map((data) => ProductList.fromJson(data)).toList(); // Convert JSON to your model
        update();
      } else {
        await Future.delayed(Duration(seconds: 2));
        searchResults.value = [];
      }
    } catch (e) {
      searchResults.value = [];
    } finally {
      isLoading(false);
    }
  }


  String formatPrice(String price) {
    try {
      // Replace commas with periods to handle different decimal formats
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








