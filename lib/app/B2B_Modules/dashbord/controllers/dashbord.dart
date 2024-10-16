import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/app/B2B_Modules/dashbord/model_b2b.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardB2BController extends GetxController {
  // Reactive state variables
  var title = 'Dashboard'.obs;
  var isLoading = false.obs;
  var b2bdashbord = <b2bDashboard>[
    b2bDashboard(
      icon: "assets/images/offer.jpg",
      text: 'Offer',
      count: 0.obs,
    ),
    b2bDashboard(
      icon: "assets/images/order.jpg",
      text: 'Orders',
      count: 0.obs,
    ),
    b2bDashboard(
      icon: "assets/images/bill.jpg",
      text: 'Bills',
      count: 0.obs,
    ),
    b2bDashboard(
      icon: "assets/images/credit-note.jpg",
      text: 'Credit Note',
      count: 0.obs,
    ),
    b2bDashboard(
      icon: "assets/images/needhelpmanager.jpg",
      text: 'Need Help Manager',
      count: 0.obs,
    ),
    b2bDashboard(
      icon: "assets/images/dealmaker.jpg",
      text: 'Dealmaker',
      count: 0.obs,
    ),
    b2bDashboard(
      icon: "assets/images/needhelpmanager.jpg",
      text: 'Addressbook',
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
        Get.snackbar('Error', 'Failed to fetch notifications', duration: Duration(seconds: 1));
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e', duration: Duration(seconds: 2));
    } finally {
      isLoading(false);
    }
  }

  void fetchCountsFromApi() async {
    await notificationsApi();
  }

  void updateCounts(Map<String, dynamic> response) {
    b2bdashbord[0].count.value = response['newB2bOffer'] ?? 0;
    b2bdashbord[1].count.value = response['newB2bAssignment'] ?? 0;
    b2bdashbord[2].count.value = response['newB2bBills'] ?? 0;
    b2bdashbord[3].count.value = response['newB2bCredits'] ?? 0;
    b2bdashbord[4].count.value =  response['newB2bClaim'] ?? 0;
    b2bdashbord[5].count.value = response['newB2bDelivery'] ?? 0;
    b2bdashbord[6].count.value = response['newB2bCredits'] ?? 0;
  }

  Future<void> launchURL() async {
    final url = ApiService.webUrl;
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



// {
// "success": {
// "headers": {},
// "original": {
// "unread_notifications": [
// {
// "id": 176,
// "type": "App\\Notifications\\DashbaordNotification",
// "notifiable_type": "App\\Models\\User",
// "notifiable_id": 10010,
// "data": "{\"user_id\":10010,\"action\":\"12\",\"offer_id\":\"AB-1234\"}",
// "read_at": null,
// "created_at": "2024-07-19T11:59:39.000000Z",
// "updated_at": "2024-07-19T11:59:39.000000Z"
// },
//
// {
// "id": 184,
// "type": "App\\Notifications\\DashbaordNotification",
// "notifiable_type": "App\\Models\\User",
// "notifiable_id": 10010,
// "data": "{\"user_id\":10010,\"action\":\"13\",\"offer_id\":\"LI-1234\"}",
// "read_at": null,
// "created_at": "2024-07-19T12:02:08.000000Z",
// "updated_at": "2024-07-19T12:02:08.000000Z"
// },
// {
// "id": 185,
// "type": "App\\Notifications\\DashbaordNotification",
// "notifiable_type": "App\\Models\\User",
// "notifiable_id": 10014,
// "data": "{\"user_id\":10014,\"action\":\"13\",\"offer_id\":\"LI-1234\"}",
// "read_at": null,
// "created_at": "2024-07-19T12:02:08.000000Z",
// "updated_at": "2024-07-19T12:02:08.000000Z"
// },
// {
// "id": 190,
// "type": "App\\Notifications\\DashbaordNotification",
// "notifiable_type": "App\\Models\\User",
// "notifiable_id": 10014,
// "data": "{\"user_id\":10014,\"action\":\"14\",\"offer_id\":\"CL-1234\"}",
// "read_at": null,
// "created_at": "2024-07-19T12:12:41.000000Z",
// "updated_at": "2024-07-19T12:12:41.000000Z"
// },
//
// {
// "id": 209,
// "type": "App\\Notifications\\DashbaordNotification",
// "notifiable_type": "App\\Models\\User",
// "notifiable_id": 10010,
// "data": "{\"user_id\":10010,\"action\":\"13\",\"offer_id\":\"LI-1236\"}",
// "read_at": null,
// "created_at": "2024-07-22T05:29:33.000000Z",
// "updated_at": "2024-07-22T05:29:33.000000Z"
// },
//
// ],
// "customer_count": 0,
// "supplier_count": 0
// },
// "exception": null
// },
// "offer_success": {
// "headers": {},
// "original": {
// "unread_notifications": [
// {
// "id": 176,
// "type": "App\\Notifications\\DashbaordNotification",
// "notifiable_type": "App\\Models\\User",
// "notifiable_id": 10010,
// "data": "{\"user_id\":10010,\"action\":\"12\",\"offer_id\":\"AB-1234\"}",
// "read_at": null,
// "created_at": "2024-07-19T11:59:39.000000Z",
// "updated_at": "2024-07-19T11:59:39.000000Z"
// },
//
// ],
// "offer_count": 0
// },
// "exception": null
// },
// "claim_success": {
// "headers": {},
// "original": {
// "unread_notifications": [
// {
// "id": 176,
// "type": "App\\Notifications\\DashbaordNotification",
// "notifiable_type": "App\\Models\\User",
// "notifiable_id": 10010,
// "data": "{\"user_id\":10010,\"action\":\"12\",\"offer_id\":\"AB-1234\"}",
// "read_at": null,
// "created_at": "2024-07-19T11:59:39.000000Z",
// "updated_at": "2024-07-19T11:59:39.000000Z"
// },
//
// ],
// "claims_count": 0
// },
// "exception": null
// },
// "newB2bB2c_success": 0,
// "newReviews": 0,
// "newB2bOffer": 1,
// "newB2bAssignment": 0,
// "newB2bDelivery": 0,
// "newB2bClaim": 0,
// "newB2bBills": 0,
// "newB2bCredits": 0
//}