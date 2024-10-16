import 'package:get/get.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'dart:typed_data'; // Import this for Uint8List
import 'package:docx_to_text/docx_to_text.dart'; // Import the docx_to_text library

class WordDocController extends GetxController {
  var isLoading = true.obs;
  var docxContent = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadDocx();
  }

  Future<void> loadDocx() async {
    isLoading(true);
    try {
      // Load DOCX from assets
      final ByteData data = await rootBundle.load('assets/docx/Imprint.docx');
      final List<int> bytes = data.buffer.asUint8List();

      // Convert List<int> to Uint8List
      final Uint8List uint8list = Uint8List.fromList(bytes);

      // Parse the DOCX file and extract text
      final text = docxToText(uint8list); // Using docx_to_text to extract text
      docxContent.value = text; // Update observable with the extracted text
    } catch (e) {
      print("Error loading DOCX: $e");
    } finally {
      isLoading(false);
    }
  }
}
