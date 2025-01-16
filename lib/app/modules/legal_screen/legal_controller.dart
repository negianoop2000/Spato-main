import 'package:get/get.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'dart:typed_data'; // Import this for Uint8List
import 'package:docx_to_text/docx_to_text.dart';

import '../../../utils/constants/api_service.dart'; // Import the docx_to_text library

class WordDocController extends GetxController {
  var isLoading = true.obs;
  var docxContent = ''.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   loadDocx();
  // }
  //
  // Future<void> loadDocx() async {
  //   isLoading(true);
  //   try {
  //     // Load DOCX from assets
  //     final ByteData data = await rootBundle.load('assets/docx/Imprint.docx');
  //     final List<int> bytes = data.buffer.asUint8List();
  //
  //     // Convert List<int> to Uint8List
  //     final Uint8List uint8list = Uint8List.fromList(bytes);
  //
  //     // Parse the DOCX file and extract text
  //     final text = docxToText(uint8list); // Using docx_to_text to extract text
  //     docxContent.value = text; // Update observable with the extracted text
  //   } catch (e) {
  //     print("Error loading DOCX: $e");
  //   } finally {
  //     isLoading(false);
  //   }
  // }


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
      var response = await ApiService().getprivacypolicies("LegalNotice", userid);
      print(response);

      // Check if the response contains the content field
      if (response != null && response['content'] != null) {
        docxContent.value = response['content']['content'] ?? "No terms and conditions available.";
      } else {
        docxContent.value = "Failed to load terms and conditions.";
      }
    } catch (e) {
      docxContent.value = "An error occurred: $e";
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
