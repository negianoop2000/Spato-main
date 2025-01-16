import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';


import 'dart:io';
import 'package:file_picker/file_picker.dart';

class RequestQuoteScreenController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  var productID = "".obs;
  var productcode = "".obs;
  var selectedFile = Rx<File?>(null);
  var countryCode = '+49'.obs;

  TextEditingController companyNameController = TextEditingController();
  TextEditingController contactNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController sparePartsController = TextEditingController();
  TextEditingController quoteNeededController = TextEditingController();
  TextEditingController briefOverviewController = TextEditingController();



  TextEditingController productidController = TextEditingController();
  TextEditingController productcodeController = TextEditingController();
  TextEditingController companymobileController = TextEditingController();
  TextEditingController companyemailController = TextEditingController();

  var selectedBudgetOption = ''.obs;

  @override
  void onInit() {
    super.onInit();
    profileUserApi();
    if (Get.arguments != null) {
      var args = Get.arguments as Map<String, dynamic>;
      productID.value = args["productID"] ?? '';
      productcode.value = args["productCode"] ?? '';

      productidController.value = TextEditingValue(text: productID.value);
      productcodeController.value = TextEditingValue(text: productcode.value);

      print('Product ID: ${productID.value}, Product Code: ${productcode.value}');
    } else {
      print('No arguments received');
    }

  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      selectedFile.value = File(result.files.single.path!);
      print('Selected file: ${selectedFile.value!.path}'); // Debug the file path
    } else {
      // User canceled the picker
      Get.snackbar('Error', 'No file selected', duration: Duration(seconds: 1));
    }
  }

  void validation(BuildContext context) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp emailRegExp = RegExp(emailPattern);
    if (companyNameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter Company name', duration: Duration(seconds: 1));
    } else if (contactNameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter Contact name', duration: Duration(seconds: 1));
    } else if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your email', duration: Duration(seconds: 1));
    } else if (!emailRegExp.hasMatch(emailController.text)) {
      Get.snackbar('Error', 'Please enter a valid email address', duration: Duration(seconds: 1));
    } else if (phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your phone number', duration: Duration(seconds: 1));
    } else if (sparePartsController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter Spare Parts name', duration: Duration(seconds: 1));
    } else if (quoteNeededController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter Quote Needed field', duration: Duration(seconds: 1));
    } else if (briefOverviewController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter Overview field', duration: Duration(seconds: 1));
    } else if (selectedFile.value == null) {
      Get.snackbar('Error', 'Please upload a file', duration: Duration(seconds: 1));
    } else {
      print("submitQuoteApi calling ...... ");
      submitQuoteApi(context);
    }
  }

  Future<void> profileUserApi() async {
    print("Fetching profile data");
    try {
      isLoading(true);
      var response = await ApiService().profileUser();
      print('Profile user response: $response');
      if (response != null && response['success'] != null) {
        var userData = response['success'];
        contactNameController.text = response['userName'] ?? '';
        emailController.text = response['userEmail'] ?? '';
        phoneController.text = userData['userMobile'] ?? '';
        companyNameController.text = userData['company_name'] ?? '';
        companyemailController.text = userData['company_mail']?? '';
        companymobileController.text = userData['company_mobile']?? '';

      } else {
        //   Get.snackbar('Error', 'No Profile',duration: Duration(seconds: 1));
      }
    } catch (e) {
      print('Error fetching profile data: $e');
      //   Get.snackbar('Error', 'Error fetching profile data',duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }

  Future<void> submitQuoteApi(BuildContext context) async {
    try {
      isLoading(true);

      var response = await ApiService().submitQuotesApi(
        productID.value,
        productcode.value,
        companyNameController.text,
        companymobileController.text,
        companyemailController.text,
        contactNameController.text,
        emailController.text,
        phoneController.text,
        sparePartsController.text,
        quoteNeededController.text,
        selectedBudgetOption.value,
        briefOverviewController.text,
        selectedFile.value!, // Pass the file here
      );

      print('Submit quote response =========== $response');
      if (response['success'] == 1) {
        Get.snackbar(
          'Success',
          response['message'] ?? 'Spare Part Request submitted successfully',
          duration: Duration(seconds: 1),
        );
        Get.back();
      } else {
        Get.snackbar(
          'Error',
          response['error'] ?? 'Request submission failed',
          duration: Duration(seconds: 1),
        );
      }
    } catch (e) {
      print('Error: $e');
      // Show a generic error message
      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
        duration: Duration(seconds: 1),
      );
    } finally {
      isLoading(false);
    }
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    companyNameController.dispose();
    contactNameController.dispose();
    companymobileController.dispose();
    companyemailController.dispose();
    emailController.dispose();
    phoneController.dispose();
    sparePartsController.dispose();
    quoteNeededController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}



