import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utils/constants/api_service.dart';
import '../model_chartdata.dart';
import 'package:http/http.dart' as http;
class B2bShopAdminController extends GetxController {

  final String userid;

  B2bShopAdminController({required this.userid});

  var selectedMonth = "Choose Month".obs;
  var shopStatus = "".obs;
  var shopId = "".obs;
  var shopname = ''.obs;

  var minimumShopCharges = 0.0.obs;
  var commissionOnSale = 0.0.obs;
  var chartData = <ChartData>[].obs;
  var subscriptions = <Map<String, dynamic>>[].obs;
  var monthOptions = ['Choose Month'].obs;
  final TextEditingController textController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void onReady() {
    super.onReady();
    fetchData();
  }

  void updateShopName(String name) {
    shopname.value = name;
  }

  Future<void> updateSubscription(String userid, String feature, String newStatus, String charge, int index) async {
    try {
      var response = await ApiService().changeStatusSubscribe(userid, feature, newStatus, charge);

      if (response['success'] == true && response['user'] == 'b2b') {
        Get.snackbar(
          'Success',
          'Your Subscription status will change after admin approval',
          duration: const Duration(seconds: 1),
        );
      } else {
        print('Subscription status change successful and user is admin b2b.');
        toggleSubscription(index);
        update();

      }

    } catch (e) {
      print('Error changing status: $e');
    }
  }


  Future<void> updateFeatureCharge(String userid, String feature, String charge,int index) async{
    try{
      var response = await ApiService().savefeaturecharge(userid,feature,charge);
      print(response);
      if(response['status']==1){
        print("price updated");
        updateSubscriptionPrice(index,double.parse(charge));
        update();
      }
    }catch (e) {
      print('Error updating price : $e');
    }


  }


  Future<void> fetchData() async {
    try {
      var response = await ApiService().profileUserExtraDetail();

      if (response != null && response['success'] != null) {
        var encryptedUserId = response['encrypted_user_id'];
        print('Encrypted UserId: $encryptedUserId');

        if (encryptedUserId != null) {
          var shopResponse = await ApiService().getb2bshop_detailsforadmin(encryptedUserId, userid);
          print('Shop Response: $shopResponse');

          if (shopResponse != null && shopResponse['shop_details'] != null) {



            var shopDetails = shopResponse['shop_details'][0];
            List premiumCharges = shopDetails['premium_charges'];

            shopStatus.value = shopResponse['b2b_shop_status'].toString();
            shopId.value = shopDetails['b2b_shop_id'];

            shopname.value = shopDetails['shop_name'];
            var createdAt = shopDetails['created_at'];
            _initializeMonthOptions(createdAt);
            minimumShopCharges.value = double.parse(shopDetails['minimum_shop_charges']);
            commissionOnSale.value = double.parse(shopDetails['commision_on_sale']);

            subscriptions.value = premiumCharges.map((subscription) {
              return {
                'name': subscription['feature'],
                'price': double.tryParse(subscription['feature_charge']?.toString() ?? '0') ?? 0.0,
                'subscribed': subscription['Status'] == 'Subscribe',
                'newStatusRequest': subscription['new_status_request'] == 0
                    ? "I want to Un-Subscribe"
                    : subscription['new_status_request'] == 1
                    ? "I want to Subscribe"
                    : null,
              };

            }).toList();
            update();
            print('Subscriptions: $subscriptions');
          }
        }
      }
    } catch (e) {
      print('Error fetching profile data: $e');
    }
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



  void onMonthChanged(String? newMonth) {
    if (newMonth != null) {
      selectedMonth.value = newMonth;
    }
  }

  void toggleSubscription(int index) {
    subscriptions[index]['subscribed'] = !subscriptions[index]['subscribed'];
    subscriptions.refresh();
  }

  void updateSubscriptionPrice(int index, double newPrice) {
    subscriptions[index]['price'] = newPrice;
    subscriptions.refresh();
    update();
  }


  Future<void> updateSubscriptionShopPrice(String userId, String price) async {
    try {
      var response = await ApiService().savesubscriptioncharge(userId, price);

      if (response['status'] == 1) {
        print('Subscription Shop price updated successfully.');
        commissionOnSale.value = double.parse(price);
        update();
      } else {
        print('Failed to update subscription price. Status: ${response['status']}');
      }
    } catch (e) {
      print("Error in updating: $e");
    }
  }

  Future<void> savePaymentAlertMessage(String userid, String message) async {
    try {
      var response = await ApiService().savepaymentalertmessage(userid, message);
        print(response);
      if (response['success'] == "Message Updated Successfully") {
        print("success");
      } else {
        print('Failed, Status: ${response['status']}');
      }
    } catch (e) {
      print("Error in updating: $e");
    }
  }


  Future<void> paymentAlertStatus(String userid, String status) async {
    try {
      var response = await ApiService().paymentalertstatus(userid, status);
         print(response);
      if (response['status'] == 1) {
      } else {
        print('Failed ,Status: ${response['status']}');
      }
    } catch (e) {
      print("Error in updating: $e");
    }
  }

}
