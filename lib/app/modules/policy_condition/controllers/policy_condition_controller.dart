import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../utils/constants/api_service.dart';

  class PolicyConditionController extends GetxController {
    final count = 0.obs;
    var isLoading = false.obs;
    final RxString policyConditionsText = "".obs;

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
        var response = await ApiService().getprivacypolicies("PrivacyPolicy", userid);
        print(response);

        // Check if the response contains the content field
        if (response != null && response['content'] != null) {
          policyConditionsText.value = response['content']['content'] ?? "No terms and conditions available.";
        } else {
          policyConditionsText.value = "Failed to load terms and conditions.";
        }
      } catch (e) {
        policyConditionsText.value = "An error occurred: $e";
        print("Error: $e");
      } finally {
        isLoading.value = false;
      }
    }

    @override
    void onReady() {
      super.onReady();
    }

    @override
    void onClose() {
      super.onClose();
    }

    void increment() => count.value++;
  }

