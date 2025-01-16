import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class Drawer_B2B extends StatelessWidget {

  var isLoading = false.obs;
  Future<void> removeLogoutPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('role');
  }

  Future<void> logoutUser() async {
    try {
      isLoading(true);
      var response = await ApiService().userLogoutApi();
      // if (response != null && response['status'] == 1) {
      if(response!=null){

        Get.snackbar('Success', response['message'] ?? 'Sign Out successful');
        await removeLogoutPreferences();
        Get.offNamed(Routes.LOGIN); // Navigate to login screen
      } else {
        isLoading(false);
        Get.snackbar('Error', response['message'] ?? 'Logout failed');
      }
    } catch (error) {
      isLoading(false);
      print('Error logging out: $error');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading(false);
    }
  }

  Future<void> _launchURL() async {
    final url = ApiService.webUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar('Error', 'Could not launch URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: Text('Dashbord'),
            onTap: () {
              Get.toNamed(Routes.DASHBORD_B2B);
            },
          ),
          ListTile(
            title: Text('Offer'),
            onTap: () {
              Get.toNamed(Routes.OFFER_B2B_SCREEN);
            },
          ),
          ListTile(
            title: Text('Orders'),
            onTap: () {
              Get.toNamed(Routes.ORDER_B2B_SCREEN);
            },
          ),
          ListTile(
            title: Text('Bills'),
            onTap: () {
              Get.toNamed(Routes.BILLS_SCREEN);
            },
          ),
          ListTile(
            title: Text('Credit Notes'),
            onTap: () {
              Get.toNamed(Routes.CREDIT_NOTES_SCREEN);
            },
          ),
          ListTile(
            title: Text('Dealmaker'),
            onTap: () {
              Get.toNamed(Routes.DEALMAKER_SCREEN);
            },
          ),
          ListTile(
            title: Text('Address Book'),
            onTap: () {
              Get.toNamed(Routes.ADDRESSBOOK_SCREEN);
            },
          ),
          ListTile(
            title: Text('Need Help Manager'),
            onTap: () {
              _launchURL();
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () async {
              logoutUser();
            },
          ),
        ],
      ),
    );
  }
}
