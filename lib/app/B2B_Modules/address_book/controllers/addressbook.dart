import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/app/B2B_Modules/address_book/views/addressbook.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';

class AddressbookB2BController extends GetxController {
  // Reactive state variables
  var title = 'Addressbook'.obs;
  var isLoading = false.obs;
  var userId = 0.obs;

  // Text controllers
  TextEditingController cityController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController emailControler = TextEditingController();
  TextEditingController repeatUserNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController streetNumberController = TextEditingController();
  var isDropdownOpen = false.obs;
  RxString selectedCountry = "Germany".obs;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    profileUserApi();
    addressListFetched();
  }

  Future<void> profileUserApi() async {
    print("Fetching profile data");
    try {
      isLoading(true);
      var response = await ApiService().profileUserExtraDetail();
      print('Profile user response: $response');
      if (response != null && response['success'] != null) {
        var userData = response['success'];
        userId.value = userData['id'] ?? '';
       // cityController.text = userData['city'] ?? '';
      //  zipCodeController.text = userData['zipCode'] ?? '';
      //  countryController.text = userData['country'] ?? '';
        emailControler.text = userData['email'] ?? '';
      //  addressController.text = userData['address'] ?? '';
        repeatUserNameController.text = userData['name'] ?? '';
        phoneNumberController.text = userData['mobile'] ?? '';
      } else {
        Get.snackbar('Error', 'No Profile');
      }
    } catch (e) {
      print('Error fetching profile data: $e');
      Get.snackbar('Error', 'Error fetching profile data');
    } finally {
      isLoading(false);
    }
  }

  void validation() {
    if (addressController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a Street');
    } else if (streetNumberController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a street number');
    }
    else if (cityController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a city');
    } else if (zipCodeController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your Zipcode');
    } else if (countryController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your Country');
    } else {
      addAddressApi();
    }
  }

  Future<void> addAddressApi() async {
    print("add address api calling data");
    try {
      isLoading(true);  // To show the loading indicator

      // Call the API
      var response = await ApiService().b2b_saveContactAddress(
        repeatUserNameController.text,
        emailControler.text,
        phoneNumberController.text,
        userId.string,
        addressController.text,
        cityController.text,
        zipCodeController.text,
        countryController.text,
        streetNumberController.text,
      );

      print('Full add address response: $response');

      if (response != null && response.containsKey('success')) {
        print("Success message: ${response['success']}");

        // Ensure UI context is ready before showing snackbar
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.snackbar('Success', response['success'].toString(),
            duration: Duration(seconds: 2),);
        });

        addressListFetched();
        Get.back();
      } else {

      }
    } catch (e) {
      print('Error caught: $e');

    } finally {
      isLoading(false);  // Ensure loading indicator is hidden
    }
  }





  Future<void> deleteAddressApi(int addressId) async {
    print("delete address api calling data");
    try {
      isLoading(true);
      var response = await ApiService().b2b_deleteTempAddress(addressId);
      print('delete address response: $response');
      if (response != null) {
        Get.snackbar('Success', 'Successfully deleted address',duration: Duration(seconds: 1));
        addressListFetched();
      } else {
    //    Get.snackbar('Error', 'Address not deleted');
      }
    } catch (e) {
  //    Get.snackbar('Error', 'Error: delete not added');
    } finally {
      isLoading(false);
    }
  }

  RxList<Map<String, dynamic>> addresses = <Map<String, dynamic>>[].obs;
  RxInt selectedAddressId = 0.obs;

  Future<void> addressListFetched() async {
    try {
      isLoading(true);
      var response = await ApiService().b2b_showTempAddress();
      if (response != null) {
        List permanentAddresses = response['permanent'];
        List userTempAddresses = response['temp'];

        // Combine both lists and map to the required format
        addresses.assignAll([
          ...permanentAddresses.map((address) => formatAddress(address)).toList(),
          ...userTempAddresses.map((address) => formatAddress(address)).toList()
        ]);

        // Set the default selected address ID to the first permanent address if available
        if (permanentAddresses.isNotEmpty) {
          selectedAddressId.value = addresses.first['id'];
        }

   //     Get.snackbar('Success', 'Address fetched successfully.', duration: Duration(seconds: 1));
      } else {
   //     Get.snackbar('Error', 'Address fetch unsuccessful.', duration: Duration(seconds: 1));
      }
    } catch (e) {
  //    Get.snackbar('Error', 'An error occurred.', duration: Duration(seconds: 1));
    } finally {
      isLoading(false);
    }
  }

  Map<String, dynamic> formatAddress(Map<String, dynamic> address) {
    return {
      'id': address['id'],
      'formattedAddress': "${address['permanent_address']}, ${address['city']}, ${address['zipCode']}, ${address['country']}"
    };
  }

  void selectAddress(int? id) {
    selectedAddressId.value = id ?? 0;
  }

  void printAddressesAndSelectedId() {
    print('Selected Address ID: ${selectedAddressId.value}');
    print('Addresses:');
    for (var address in addresses) {
      print(address['formattedAddress']);
    }
  }

  @override
  void onClose() {
    cityController.dispose();
    zipCodeController.dispose();
    countryController.dispose();
    emailControler.dispose();
    repeatUserNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    streetNumberController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
  void updateTitle(String newTitle) {
    title.value = newTitle;
  }
}


