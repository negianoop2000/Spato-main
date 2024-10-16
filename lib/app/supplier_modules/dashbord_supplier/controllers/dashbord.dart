import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/app/supplier_modules/dashbord_supplier/model.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:url_launcher/url_launcher.dart';


class DashboardController extends GetxController {
  var title = 'Dashboard'.obs;
  var isLoading = false.obs;
  var b2bdashbord = <supplierDashboard>[
    supplierDashboard(
      icon: "assets/images/order.jpg",
      text: 'Orders',
      count: 0.obs,
    ),
    supplierDashboard(
      icon: "assets/images/bill.jpg",
      text: 'Delivery Notes',
      count: 0.obs,
    ),
    supplierDashboard(
      icon: "assets/images/needhelpmanager.jpg",
      text: 'Need Help Manager',
      count: 0.obs,
    ),

  ].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCountsFromApi();
  }

  Future<void> notificationsApi() async {
    isLoading(true);
    try {
      var response = await ApiService().notificationsApi();
      print("API Response: $response");

      if (response != null) {
        // Extract the required values
        int newReviews = response['newReviews'] ?? 0;
        int newB2bOffer = response['newB2bOffer'] ?? 0;
        int newB2bAssignment = response['newB2bAssignment'] ?? 0;
        int newB2bDelivery = response['newB2bDelivery'] ?? 0;
        int newB2bClaim = response['newB2bClaim'] ?? 0;
        int newB2bBills = response['newB2bBills'] ?? 0;
        int newB2bCredits = response['newB2bCredits'] ?? 0;

        // Print the extracted values
        print("New Reviews: $newReviews");
        print("New B2B Offer: $newB2bOffer");
        print("New B2B Assignment: $newB2bAssignment");
        print("New B2B Delivery: $newB2bDelivery");
        print("New B2B Claim: $newB2bClaim");
        print("New B2B Bills: $newB2bBills");
        print("New B2B Credits: $newB2bCredits");

        // Update counts in the dashboard
        updateCounts(response);
      } else {
   //     Get.snackbar('Error', 'Failed to fetch notifications', duration: Duration(seconds: 1));
      }
    } catch (e) {
   //   Get.snackbar('Error', 'An error occurred: $e', duration: Duration(seconds: 2));
    } finally {
      isLoading(false);
    }
  }
  void updateCounts(Map<String, dynamic> response) {
    b2bdashbord[0].count.value = response['newB2bAssignment'] ?? 0;
    b2bdashbord[1].count.value = response['newB2bDelivery'] ?? 0;
    b2bdashbord[2].count.value = response['newB2bDelivery'] ?? 0;
    b2bdashbord[3].count.value = response['newB2bCredits'] ?? 0;
    b2bdashbord[4].count.value =  0;
    b2bdashbord[5].count.value = response['newB2bDelivery'] ?? 0;
    b2bdashbord[6].count.value = 0;
  }

  void fetchCountsFromApi() {
    notificationsApi();
  }

  Future<void> launchURL() async {
    final url = ApiService.webUrl;
    print('Launching URL: $url');  // Add this line for debugging
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar('Error', 'Could not launch URL');
    }
  }

  void updateTitle(String newTitle) {
    title.value = newTitle;
  }
}
