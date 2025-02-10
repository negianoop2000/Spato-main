import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';

class CheckoutInformationController extends GetxController {
  //TODO: Implement CheckoutInformationController

  var isLoading = false.obs;
  var filteredCountries = <String>[].obs;

  final FocusNode countryFocusNode = FocusNode();

   TextEditingController cityController = TextEditingController();
   TextEditingController zipCodeController = TextEditingController();
   TextEditingController countryController = TextEditingController();
  TextEditingController companynameController = TextEditingController();
  TextEditingController companyemailController = TextEditingController();
  TextEditingController companyphoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();


  RxString usertype ="".obs;

  var isDropdownOpen = false.obs;
  RxString selectedCountry = "Germany".obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getusertype();
   // profileUserApi();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> getusertype() async {
    final prefs = await SharedPreferences.getInstance();

    usertype.value = prefs.getString('role')!;
     print(usertype);
  }

  // Future<void> profileUserApi() async {
  //   print("Fetching profile data");
  //   try {
  //     isLoading(true);
  //     var response = await ApiService().profileUserExtraDetail();
  //     print('Profile user response: $response');
  //     if (response != null && response['success'] != null) {
  //       var userData = response['success'];
  //    //   cityController.text = userData['city'] ?? '';
  //     //  zipCodeController.text = userData['zipCode'] ?? '';
  //    //   countryController.text = userData['country'] ?? '';
  //       emailControler.text = userData['email'] ?? '';
  //     //  addressController.text = userData['address'] ?? '';
  //       repeatUserNameController.text = userData['name'] ?? '';
  //       phoneNumberController.text = userData['mobile'] ?? '';
  //     } else {
  //     //  Get.snackbar('Error', 'No Profile');
  //     }
  //   } catch (e) {
  //     print('Error fetching profile data: $e');
  //   //  Get.snackbar('Error', 'Error fetching profile data');
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  void validation() {


    if(usertype.value=="b2b"){
      if (companyemailController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter a address',duration: Duration(seconds: 1));
      } else if (companyphoneController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter a address',duration: Duration(seconds: 1));
      } else if (companyemailController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter a address',duration: Duration(seconds: 1));
      }
    }

     if (addressController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a address',duration: Duration(seconds: 1));
    } else if (cityController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a city',duration: Duration(seconds: 1));
    } else if (zipCodeController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your Zipcode',duration: Duration(seconds: 1));
    } else if (countryController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your Country',duration: Duration(seconds: 1));
    } else {
      addAddressApi();
    }
  }

  Future<void> addAddressApi() async {
    print("add address api calling data");
    try {
      isLoading(true);
      var response = await ApiService().saveTempAddress(
          companynameController.text,
          companyemailController.text,
          companyphoneController.text,
          addressController.text,
          cityController.text,
          zipCodeController.text,
          countryController.text
      );
      print('Profile user response: $response');
      if (response != null) {
        Get.snackbar('Success', 'Successfully add address',duration: Duration(seconds: 1));

        Get.toNamed(Routes.CHECKOUT_SHIPPING, arguments: {
        if (Get.arguments['callback'] != null)
        {
        Get.arguments['callback'](),
        },
        Get.back(),
        },);
      } else {
        Get.snackbar('Error', 'address not add',duration: Duration(seconds: 1));
      }
    } catch (e) {
    //  Get.snackbar('Error', 'Error address not add',duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    cityController.dispose();
    zipCodeController.dispose();
    countryController.dispose();
    companynameController.dispose();
    companyphoneController.dispose();
    companyemailController.dispose();
    addressController.dispose();
    countryFocusNode.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
