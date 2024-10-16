import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/app/data/model/detail_data_model.dart';
import 'package:spato_mobile_app/app/data/model/sparePart_model.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';


class SparePartScreenController extends GetxController {
  final List<SparePart> spareParts = Get.arguments['spareParts'];
  var count = 0.obs;
  var isLoading = false.obs;
  var imageUrl = "".obs;
  RxList<SparPart> inputSparPartList = <SparPart>[].obs;
  RxDouble totalPrice = 0.0.obs;
  var verticalScrollController = ScrollController();
  var horizontalScrollController = ScrollController();
  final Rx<Offset?> tapPosition = Rx<Offset?>(null);
  RxList<Offset> AllTapPosition = <Offset>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchSparePartImages();
  }



  Future<void> fetchSparePartImages() async {
    try {
      isLoading(true);
      for (var sparePart in spareParts) {
        await getSparepartImage(sparePart.productId.toString());
      }
    } catch (e) {
      print('Error fetching spare part images: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getSparepartImage(String productId) async {
    try {
      var response = await ApiService().getSparepartImage(productId);
      print('SparePart Image API response: $response');
      if (response != null && response['sparePartImage'] != null) {
        await get_image(response['sparePartImage']['Bild_1']);
      }
    } catch (e) {
      print('Error fetching spare part image: $e');
    }
  }

  Future<void> get_image(String imageBuild) async {
    try {
      var response = await ApiService().get_Image(imageBuild);
      if (response.containsKey('url')) {
        imageUrl.value = response['url'];
        print('Image URL: ${imageUrl.value}');
      }
    } catch (e) {
      print('Error fetching image data: $e');
    }
  }

  var tableData = <Map<String, dynamic>>[].obs;
  var errorMessage = ''.obs;


  Future<void> extractText_sparePart(String x,String y, String productId) async {
    try {
     // isLoading(true);
      var response = await ApiService().extractText_sparePartApi(x,y, productId);
      print('Spare part response: $response');

      if (response != null && response['filteredData'] != null) {
        final item = response['filteredData'];

        SparPart newPart = SparPart(
          partNo: item['part_no'] ?? '',
          artikelnummer: item['Artikelnummer'] ?? '',
          beschreibung: item['Beschreibung'] ?? '',
          id: item['id'] ?? 0,
          rate: item['rate'] ?? 0.0,
          discountPercentage: double.tryParse(item['discount_percentage']) ?? 0.0,
          finalRate: item['final_rate']?.toDouble() ?? 0.0,
          productId: item['product_id'] ?? '',
        );

        inputSparPartList.add(newPart);  // Add the mapped part to the list
        print('Spare part added to input list: ${inputSparPartList.last}');
        calculateTotalPrice();
     //   isLoading(false);
      } else {
        Get.snackbar("Spato.de says", response['error'], duration: Duration(seconds: 2));
     //   isLoading(false);
        print('No filteredData found in response');
      }
    } catch (e) {
    //  isLoading(false);
      print('Error fetching spare part text: $e');
    }
  }



  Future<void> buy_SpareParts() async {
    try {
      isLoading(true);

      if (inputSparPartList.isEmpty) {
        Get.snackbar("Can't Buy", "No spare parts added for buy", duration: Duration(seconds: 1));
        isLoading(false);
        return;
      }

      SparPart? firstPart = inputSparPartList.first;
      String? productId = firstPart.productId;

      if (productId == null || productId.isEmpty) {
        print('Product ID is missing in the first spare part.');
        isLoading(false);
        return;
      }

      List<Map<String, dynamic>> mappedParts = inputSparPartList.map((part) => {
        'POS': part.partNo ?? '',
        'Produkt': part.artikelnummer ?? '',
        'Beschreibung': part.beschreibung ?? '',
        'Spare_id': part.id?.toString() ?? '',
        'Gesamtpreis': part.rate ?? '0', // Assuming 'rate' is a string
        'discount_percentage': part.discountPercentage?.toString() ?? '0',
        'final_rate': part.finalRate?.toString() ?? '0',
      }).toList();


      var response = await ApiService().addSparePartOfferUrl(mappedParts, productId);

      print('Spare part add response : $response');

      if (response != null && response['success'] != null) {

        Get.snackbar("Success", response['success'], duration: Duration(seconds: 2));
        inputSparPartList.clear();
      } else {

      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      print('Error sending spare part offer: $e');
    }
  }

  void deleteSparePart(int index) {
    if (index >= 0 && index < inputSparPartList.length) {
      inputSparPartList.removeAt(index);
      calculateTotalPrice();
      print('Spare part removed at index $index. Updated list: $inputSparPartList');
    } else {
      print('Invalid index: $index. Cannot delete.');
    }
  }

  void calculateTotalPrice() {
    double sum = inputSparPartList.fold(0.0, (total, part) => total + (double.tryParse(part.rate ?? '0') ?? 0.0));
    totalPrice.value = sum;
  }



  @override
  void onClose() {
    super.onClose();
    verticalScrollController.dispose();
    horizontalScrollController.dispose();
  }

  void increment() => count.value++;
}



