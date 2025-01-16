import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/app/modules/editProfile/controllers/image_model.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';


class editProfileController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  var filteredCountries = <String>[].obs;
  var image = Rx<File?>(null);
  var userImage = ''.obs;
  var userEmail = ''.obs;
  var isDropdownOpen = false.obs;
  RxString selectedCountry = "Germany".obs;
  late final ImageModel _model;
  bool _detectPermission = false;


  TextEditingController cityController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController vatNumberController = TextEditingController();
  TextEditingController repeatUserNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController streetnameController = TextEditingController();
  TextEditingController streetnumberController = TextEditingController();

  var countryCode = '+91'.obs;


  @override
  void onInit() async {
    super.onInit();
   await profileUserApi();
  }

  void validateFields() {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp emailRegExp = RegExp(emailPattern);
      if (cityController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a city',duration: Duration(seconds: 1));
    }else if (zipCodeController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a zip code',duration: Duration(seconds: 1));
    }else if (countryController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a country',duration: Duration(seconds: 1));
    } else if (repeatUserNameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a username',duration: Duration(seconds: 1));
    } else if (phoneNumberController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a phone number',duration: Duration(seconds: 1));
    } else if (streetnameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter an address',duration: Duration(seconds: 1));
    }    else {
      updateProfile();
    }
  }

  Future<void> profileUserApi() async {

    try {
      isLoading(true);
      var response = await ApiService().profileUser();
      if (response != null && response['success'] != null) {
        var userData = response['success'];
        userImage.value = userData['profile_picture'] ?? '';
        cityController.text = userData['city'] ?? '';
        zipCodeController.text = userData['zipCode'] ?? '';
        countryController.text = userData['country'] ?? 'Germany';
        vatNumberController.text = userData['vat_number'] ?? '';
        streetnameController.text = userData['permanent_address'] ?? '';
        repeatUserNameController.text = response['userName'] ?? '';
        phoneNumberController.text = response['userMobile'] ?? '';
        userEmail.value = response['userEmail'] ?? '';
      } else {
      }
    } catch (e) {

    } finally {
      isLoading(false);
    }
  }


  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source,imageQuality: 25);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileSize = await file.length();
      final fileSizeInKB = fileSize / 1024;

      if (fileSizeInKB > 2048) {
        Get.snackbar('Error', 'The image size must not be greater than 2048 kilobytes.',duration: Duration(seconds: 1));
      } else {
        image.value = file;
      }
    }
  }

  Future<void> _checkPermissionsAndPick() async {
    final hasFilePermission = await _model.requestFilePermission();
    if (hasFilePermission) {
      try {
        await _model.pickFile();
      } on Exception catch (e) {
        debugPrint('Error when picking a file: $e');
        // Show an error to the user if the pick file failed



    }
  }
}


  ImageSection _imageSection = ImageSection.browseFiles;

  ImageSection get imageSection => _imageSection;

  set imageSection(ImageSection value) {
    if (value != _imageSection) {
      _imageSection = value;
      //  notifyListeners();
    }
  }
  File? file;

  Future<bool> requestFilePermission() async {
    PermissionStatus result;
    if (Platform.isAndroid) {
      result = await Permission.storage.request();
    } else {
      result = await Permission.photos.request();
    }

    if (result.isGranted) {
      imageSection = ImageSection.browseFiles;
      return true;
    } else if (Platform.isIOS || result.isPermanentlyDenied) {
      imageSection = ImageSection.noStoragePermissionPermanent;
    } else {
      imageSection = ImageSection.noStoragePermission;
    }
    return false;
  }

  Future<void> pickFile() async {
    final FilePickerResult? result =
    await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null &&
        result.files.isNotEmpty &&
        result.files.single.path != null) {
      file = File(result.files.single.path!);
      imageSection = ImageSection.imageLoaded;
    }
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();
    if (status.isGranted) {
    } else if (status.isDenied) {
      Get.snackbar('Permission', 'Permission denied',duration: Duration(seconds: 1));
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
                  await requestFilePermission();
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () async {
                  await requestFilePermission();
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

  Future<void> updateProfile() async {
    try {
      isLoading(true);
      var response = await ApiService().editProfile(
        cityController.text,
        zipCodeController.text,
        countryController.text,
        userEmail.value,
        vatNumberController.text,
        repeatUserNameController.text,
        streetnameController.text,
        phoneNumberController.text,
        image.value,
      );

      if (response != null && response.containsKey('success')) {
        profileUserApi();
        Get.snackbar('Success', response['success'],duration: Duration(seconds: 1));
      } else {
       Get.snackbar('Error', response['imageUpload'] ?? 'Profile update failed',duration: Duration(seconds: 1));
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    cityController.dispose();
    zipCodeController.dispose();
    countryController.dispose();
    vatNumberController.dispose();
    repeatUserNameController.dispose();
    phoneNumberController.dispose();
    streetnameController.dispose();
    countryCode.value = '';
    super.onClose();
  }

  void increment() => count.value++;
}