import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';

class SignUpInfoController extends GetxController {
  final count = 0.obs;
  var image = Rx<File?>(null);
  var userNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var addressController = TextEditingController();
  var streetnameController = TextEditingController();
  var streetnumberController = TextEditingController();
  var userCityController = TextEditingController();
  var userCountryController = TextEditingController();
  var userPincodeController = TextEditingController();
  var userCompanyController = TextEditingController();
  var userVatIdController = TextEditingController();
  var countryCode = '+49'.obs;
  var selectedRole = ''.obs;
  var selectedPrefix = 'Mr.'.obs;
  var isDropdownOpen = false.obs;
  RxString selectedCountry = "Germany".obs;

  @override
  void onInit() {
    super.onInit();
    userCountryController.text = selectedCountry.value;
  }


  void printControllerText() {
    print(userNameController.text);
    print(phoneNumberController.text);
    print(addressController.text);
    print(countryCode.value);
    print(selectedRole.value);
  }

  void updateUserNameWithPrefix() {
    String currentName = userNameController.text;
    currentName = currentName.replaceAll(RegExp(r'^(Mr\.|Mrs\.)\s*'), '');
    userNameController.text = '${selectedPrefix.value} $currentName';
  }

  void validation(BuildContext context) {
    if (userNameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your Name');
    } else if (phoneNumberController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your phone number');
    } else if (phoneNumberController.text.length != 10) {
      Get.snackbar('Error', 'Please enter a valid phone number');
    } else if (streetnameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter House number');
    } else if (streetnumberController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter Street Address');
    } else if (userCityController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your City');
    } else if (userCountryController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter Country');
    } else if (userPincodeController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter Pincode');
    } else if (selectedRole.value.isEmpty) {
      Get.snackbar('Error', 'Please select a role');
    } else if ((selectedRole.value == "b2b" || selectedRole.value == "supplier") &&
        (userCompanyController.text.isEmpty || userVatIdController.text.isEmpty)) {
      if (userCompanyController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter Company name');
      }
      if (userVatIdController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter VAT ID');
      }
    } else {
      saveSharedPreferences();
      Get.toNamed(Routes.SIGN_UP);
      printControllerText();
    }
  }
  void saveSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', userNameController.text);
    await prefs.setString('phone_number', phoneNumberController.text);
    await prefs.setString('house_no', streetnameController.text);
    await prefs.setString('street', streetnumberController.text);
    await prefs.setString('city', userCityController.text);
    await prefs.setString('country', userCountryController.text);
    await prefs.setString('pincode', userPincodeController.text);
    await prefs.setString('companyName', userCompanyController.text);
    await prefs.setString('vatID', userVatIdController.text);
    await prefs.setString('country_code', countryCode.value);
    await prefs.setString('selected_role', selectedRole.value);

  }

  void toggleRole(String role) {
    selectedRole.value = role;
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();
    if (status.isGranted) {
      // Permission granted
    } else if (status.isDenied) {
      Get.snackbar('Permission', 'Permission denied');
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () async {
                  await requestPermission(Permission.photos);
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () async {
                  await requestPermission(Permission.camera);
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    userNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    countryCode.value = '';
  }

  void increment() => count.value++;
}





