import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/constants/api_service.dart';
import 'package:http/http.dart' as http;

class B2BShopController extends GetxController {
  var subscriptions = <Map<String, dynamic>>[].obs;

  var showPaymentMessage = false.obs;
  var paymentMessage = ''.obs;
  var minimumShopCharges = 0.0.obs;
  var shopId = ''.obs;
  var userid = ''.obs;

  var commissionOnSale = 0.0.obs;
  var approvalStatus = ''.obs;
  var selectedMonth = "Choose Month".obs;
  var isLoading = false.obs;

  var monthOptions = ['Choose Month'].obs;




  @override
  void onInit() {
    super.onInit();
    fetchDataApi();
  }

  void onMonthChanged(String? newMonth) {
    if (newMonth != null) {
      selectedMonth.value = newMonth;
    }
  }

  Future<void> updateSubscription(String userid, String feature, String newStatus, String charge) async {
    try {
      var response = await ApiService().changeStatusSubscribe(userid, feature, newStatus, charge);

      if (response['success'] == true && response['user'] == 'b2b') {
        Get.snackbar(
          'Success',
          'Your Subscription status will change after admin approval',
          duration: const Duration(seconds: 1),
        );
      } else {
        print('Subscription status change unsuccessful or user is not b2b.');
      }

    } catch (e) {
      print('Error changing status: $e');
    }
  }

  Future<void> fetchDataApi() async {
    print("Fetching profile data");
    try {
      isLoading(true);
      var response = await ApiService().profileUserExtraDetail();
      print('Profile user response: $response');
      if (response != null && response['success'] != null) {
        var encryptedUserId = response['encrypted_user_id'];
        print('Encrypted User ID: $encryptedUserId');
        if (encryptedUserId != null) {
          var shopResponse = await ApiService().getb2bshop_details(encryptedUserId);

          approvalStatus.value = shopResponse['shop_details'][0]['approval_status'];
          var shopDetails = shopResponse['shop_details'][0];
          var createdAt = shopDetails['created_at'];
          _initializeMonthOptions(createdAt);
          if (shopResponse != null && shopResponse['status'] == 1) {
            updateSubscriptions(shopResponse);
            updatePaymentMessage(shopResponse);
          }
        }
      } else {
        print("home1 api not working");
      }
    } catch (e) {
      print('Error fetching profile data: $e');
    } finally {
      isLoading(false);
    }
  }


  void updatePaymentMessage(Map<String, dynamic> response) {

    if (response.containsKey('payment_alert_message') && response['payment_alert_message'] != null) {
      paymentMessage.value = response['payment_alert_message'];
      showPaymentMessage.value = true;
    } else {
      showPaymentMessage.value = false;
    }
  }
  void updateSubscriptions(Map<String, dynamic> shopResponse) {
    var shopDetails = shopResponse['shop_details'][0];
    var premiumCharges = shopDetails['premium_charges'];
    // Update subscriptions
    subscriptions.value = premiumCharges.map<Map<String, dynamic>>((charge) {
      return {
        'name': charge['feature'],
        'price': charge['feature_charge'] != null ? double.parse(charge['feature_charge']) : null,
        'subscribed': charge['Status'] == 'Subscribe'
      };
    }).toList();

    minimumShopCharges.value = double.parse(shopDetails['minimum_shop_charges']);
    shopId.value = shopDetails['b2b_shop_id'];
    userid.value = shopDetails['user_id'];

    commissionOnSale.value = double.parse(shopDetails['commision_on_sale']);

    update();

  }


  void _initializeMonthOptions(String createdAt) {
    final now = DateTime.now();
    List<String> months = [];

    DateTime startDate = DateTime.parse(createdAt).copyWith(day: 1);
    DateTime endDate = DateTime(now.year, now.month, 1).subtract(Duration(days: 1));

    while (startDate.isBefore(endDate) || startDate.isAtSameMomentAs(endDate)) {
      months.add(DateFormat('MMMM yyyy').format(startDate));
      startDate = DateTime(startDate.year, startDate.month + 1, 1);
    }

    monthOptions.value = ["Choose Month", ...months.reversed];
    selectedMonth.value = "Choose Month";
    update();
  }


  Future<void> downloadReport(String selectedDate, String userId, BuildContext context) async {
    final url = Uri.parse(
      '${ApiService.baseUrl}shopBillsdownload?date=${Uri.encodeComponent(selectedDate)}&user_id=${Uri.encodeComponent(userId)}',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final contentType = response.headers['content-type'];

        if (contentType != null && contentType.contains('application/pdf')) {
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          } else {
            throw 'Could not launch $url';
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No data found for the selected date.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred while downloading.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred while downloading.')),
      );
    }
  }


}
