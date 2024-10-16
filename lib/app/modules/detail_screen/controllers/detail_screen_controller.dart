import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spato_mobile_app/app/data/model/category_productList.dart';
import 'package:spato_mobile_app/app/data/model/detail_data_model.dart';
import 'package:spato_mobile_app/app/data/model/product_wishlist.dart';
import 'package:spato_mobile_app/app/data/model/products_list.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailScreenController extends GetxController {
  var isLoading = false.obs;
  var productQuantitycount = 1.obs;
  var selectedProductIndex = 0.obs;
  var selectedProduct = ProductList().obs;

  var productDetail = Product().obs; // This will hold the detailed product data
  var spareParts = <SparePart>[].obs;
  var reviews = <Review>[].obs;
  var relateProducts = <Product_List>[].obs;
  var productsClam = <ProductWishList>[].obs;
  var review = <Review_List>[].obs;
  var images = <String>[].obs;

  final count = 0.obs;
  var rating = 0.0.obs;
  var ratingSubmit = 0.0.obs;
  var isExpanded = false.obs;
  var isExpandedDetail = false.obs;
  var isExpandedSpacification = false.obs;
  var isExpandedDownload = false.obs;
  var isExpandedReview = false.obs;
  List<ProductWishList> featuredProductsList = [];
  List<Product_List> relatedProductsList = [];
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments as Map;
    selectedProductIndex.value = arguments['index'];
    selectedProduct.value = arguments['products'][selectedProductIndex.value];
    if (selectedProduct.value.id != null && selectedProduct.value.kategorie1 != null) {
      getDetailPageApi(selectedProduct.value.id!, selectedProduct.value.kategorie1!);
    }
  }

  void incrementCount() {
    productQuantitycount.value++;
  }

  void decrementCount() {
    if (productQuantitycount.value > 0) {
      productQuantitycount.value--;
    }
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }


  Future<void> getDetailPageApi(int id, String manufacturer) async {
    try {
      isLoading(true);
      print("456456564456  $id $manufacturer");
      var response = await ApiService().productDetail(id, manufacturer);
      if (response != null) {
        print("Product detail data received: $response");

        // Handle product details
        if (response['product'] != null && response['product'] is List && response['product'].isNotEmpty) {
          List<Product> productList = (response['product'] as List)
              .map((item) => Product.fromJson(item))
              .toList();
          if (productList.isNotEmpty) {
            productDetail.value = productList.first;
          }
        }

        // Step 1: Extract image keys from the response
        List<String?> imageKeys = [
          response['product'][0]['Bild_1'],
          response['product'][0]['Bild_2'],
          response['product'][0]['Bild_3'],
          response['product'][0]['Bild_4'],
        ];

// Step 2: Filter out null or empty image keys and convert to List<String>
        List<String> filteredImageKeys = imageKeys
            .where((key) => key != null && key.isNotEmpty)
            .map((key) => key!) // Force unwrap since we know it's not null here
            .toList();

// Step 3: Initialize an empty list to store the final image URLs
        List<String> imagesList = [];

// Step 4: Loop through the filtered image keys and fetch the image URLs
        for (var key in filteredImageKeys) {
          print("Fetching image for key: $key");
          String imageUrl = await get_image(key);
          print("Fetched image URL: $imageUrl");
          imagesList.add(imageUrl);
        }

// Step 5: Clear the existing images list and update it with the new URLs
        print("Current images list before clear: $images");
        images.clear(); // Clear previous images if any
        images.addAll(imagesList); // Add new images

// Print the final images list
        print("Updated images list: $images");


// Print the final images list
        print("Updated images list: $images");



        // Handle related products
        if (response['related_Products'] != null && response['related_Products'] is List) {
          List<Product_List> relatedProductsList = (response['related_Products'] as List)
              .map((item) => Product_List(
            image: item['Bild_1'] ?? '',
            name: item['Artikelname'] ?? '',
            price: item['Preis_zzgl_MwSt'] ?? '',
            point: item['Herst_Nr'] ?? '',
            rating: item['average_rating'] ?? '',
            id: item['id'] ?? '',
            kategorie1: item['Kategorie_1'] ?? '',
            review: item['review_count']
          ))
              .toList();

          for (var product in relatedProductsList) {
            if (product.image != null && product.image!.isNotEmpty) {
              var imageUrl = await get_image(product.image!);
              product.imageUrl = imageUrl;
            }
          }
          relateProducts.assignAll(relatedProductsList);
        } else {
          relateProducts.clear();
        }

        if (response['featured_Products'] != null && response['featured_Products'] is List) {
          List<ProductWishList> featuredProductsList = (response['featured_Products'] as List)
              .map((item) => ProductWishList(
            image: item['Bild_1'] ?? '',
            title: item['Artikelname'] ?? '',
            subtitle: item['Beschreibung_kurz'] ?? '',
            price: item['Preis_zzgl_MwSt'] ?? '',
            kategorie1: item['Kategorie_1'] ?? '',
            id: item['id'] ?? '',
          ))
              .toList();

          for (var product in featuredProductsList) {
            if (product.image != null && product.image!.isNotEmpty) {
              var imageUrl = await get_image(product.image!);
              product.imageUrl = imageUrl;
            }
          }
          productsClam.assignAll(featuredProductsList);
        } else {
          productsClam.clear();
        }

        // Handle spare parts
        if (response['sparePart'] != null) {
          var sparePartData = response['sparePart'];
          SparePart sparePart = SparePart(
            id: sparePartData['id'],
            partNo: sparePartData['part_no'],
            pieces: sparePartData['pices'],
            rate: sparePartData['rate'],
            specification: sparePartData['specification'],
            description: sparePartData['Beschreibung'],
            articleNumber: sparePartData['Artikelnummer'],
            productId: sparePartData['product_id'],
            catalogueArticleNumber: sparePartData['Katalog_Art_Nummer'],
            articleName: sparePartData['Artikelname'],
            articleImage: sparePartData['Artikelbild'],
            excelFile: sparePartData['Excel_file'],
          );
          spareParts.clear();
          spareParts.add(sparePart);
        } else {
          spareParts.clear();
        }

        //////         review ///////
// "reviews": [
//         {
//             "id": 25,
//             "rating": "5.0",
//             "reviwComment": "Very Good Product",
//             "productId": "6152",
//             "userId": "10016",
//             "userName": "Sumit",
//             "showStatus": "show",
//             "created_at": "2024-08-13T05:58:04.000000Z",
//             "updated_at": "2024-08-13T05:58:32.000000Z",
//             "profile_picture": "profile_pictures/image_picker_DAFBF0B6-1F7E-43AA-A19A-346B75312C17-4119-000001647B4043C4.jpg"
//         }
//     ]
        // Handle review products
        // Handle review products
        if (response['reviews'] != null && response['reviews'] is List) {
          List<Review_List> reviewList = (response['reviews'] as List)
              .map((item) => Review_List(
            rating: double.tryParse(item['rating'] ?? '0.0'), // Parse rating as double
            reviewComment: item['reviwComment'] ?? '',
            userName: item['userName'] ?? '',
            profilePicture: item['profile_picture'] ?? '',
            createdAt: item['created_at'] ?? '',

          ))
              .toList();

          if (reviewList.isNotEmpty) {
            rating.value = reviewList.first.rating ?? 0.0;
          } else {
            rating.value = 0.0; // Set rating to 0.0 if no reviews are available
          }

          review.assignAll(reviewList);

          // Print the reviews
          print("Fetched Reviews:");
          for (var r in reviewList) {
            print("Rating: ${r.rating}, Comment: ${r.reviewComment},createdat: ${r.createdAt}, User: ${r.userName}, Profile Picture: ${r.profilePicture}");
          }
        } else {
          review.clear();
          rating.value = 0.0; // Set rating to 0.0 if no reviews are available
        }


        // Optionally, show a success message
        // Get.snackbar('Success', 'Product details loaded successfully', duration: Duration(seconds: 1));
      } else {
        // Optionally, show an error message
        // Get.snackbar('Error', 'No item found', duration: Duration(seconds: 1));
      }
    } catch (e) {
      print("Error fetching product details: $e");
      // Optionally, show an error message
      // Get.snackbar('Error', 'An error occurred', duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }

  Future<String> get_image(String imageBuild) async {
    try {
      isLoading(true);
      var response = await ApiService().get_Image(imageBuild);

      if (response is Map<String, dynamic>) {
        if (response.containsKey('url')) {
          return response['url'];
        } else if (response.containsKey('message') && response['message'] == "Image not found!") {
          return "assets/images/no-item-found.png"; // Return a default image URL
        }
      }
      isLoading(true);
      return "assets/images/no-item-found.png"; // Fallback to a default image URL
    } catch (e) {
      isLoading(true);
      print("Exception caught: $e");
      return "assets/images/no-item-found.png"; // Fallback to a default image URL on error
    }
  }




  Future<void> addToCartApi(String productid) async {
    print("dfhfdhfh ${productQuantitycount.value}");
    isLoading(true);
    try {
      var response = await ApiService().addToCardApi(
        productid,
        productQuantitycount.value,
      );
      if (response['message'] == "Item added to cart successfully") {
        Get.snackbar('Success', response['message'],duration: Duration(seconds: 1));
      } else {
     //   Get.snackbar('Error', 'Added to cart unsuccessfully',duration: Duration(seconds: 1));
      }
    } finally {
      isLoading(false);
    }
  }
  Future<void> addToCartRelatedApi(String productid) async {
    print("dfhfdhfh ${productQuantitycount.value}");
    isLoading(true);
    try {
      var response = await ApiService().addToCardApi(
        productid,
          1,
      );
      if (response['message'] == "Item added to cart successfully") {
        Get.snackbar('Success', response['message'],duration: Duration(seconds: 1));
      } else {
     //   Get.snackbar('Error', 'Added to cart unsuccessfully',duration: Duration(seconds: 1));
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> downloadAndSavePdf(String url, String fileName) async {
    print("url  $url");
    print("filename $fileName");
    String fullImageUrl = ApiService.imageUrl + url;
    print("File URL: $fullImageUrl");

    var status = await Permission.storage.request();
    if (!status.isGranted) {
      Get.snackbar('Permission Denied', 'Storage permission is required to download the file.', duration: Duration(seconds: 1));
      return;
    }

    isLoading(true);
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String savePath = "${appDocDir.path}/$fileName";

      Dio dio = Dio();
      var response = await dio.download(fullImageUrl, savePath);  // Use the correctly constructed URL

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'File downloaded successfully!', duration: Duration(seconds: 1));
      } else {
    //    Get.snackbar('Error', 'Failed to download file. Status code: ${response.statusCode}', duration: Duration(seconds: 1));
      }
    } catch (e) {
   //   Get.snackbar('Error', 'Failed to download file: $e', duration: Duration(seconds: 1));
      print('Failed to download file: $e');
    } finally {
      isLoading(false);
    }
  }




  TextEditingController reviewController = TextEditingController();
  late int totalReviews = 0;

  Future<void> reviewRating(String ratingSubmit, String feedbackComment, String productID) async {
    isLoading(true);
    try {
      var response = await ApiService().reveiwRatingApi(
          ratingSubmit,
          feedbackComment,
          productID
      );

      if (response != null) {
        if (response.containsKey('success')) {
          Get.snackbar('Success', response['success'], duration: Duration(seconds: 1));
        } else if (response.containsKey('error')) {
          Get.snackbar('Error', response['error'], duration: Duration(seconds: 1));
        }
      } else {
        Get.snackbar('Error', 'Unexpected error occurred', duration: Duration(seconds: 1));
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong', duration: Duration(seconds: 1));
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

  void toggleExpanded() {
    isExpanded.toggle();
  }

  void toggleExpandedDetail() {
    isExpandedDetail.toggle();
  }

  void toggleExpandedDownload() {
    isExpandedDownload.toggle();
  }

  void toggleSpacification() {
    isExpandedSpacification.toggle();
  }

  void toggleExpandedReview() {
    isExpandedReview.toggle();
  }

  void navigate_sparePartDetail() {
    Get.toNamed(
      Routes.SPARE_PART_SCREEN,
      arguments: {'spareParts': spareParts},
    );
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void increment() => count.value++;
}




