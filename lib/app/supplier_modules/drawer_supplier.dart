import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Drawer_S extends StatelessWidget {
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
      if (response != null && response['status'] == 1) {
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
              Get.toNamed(Routes.DASHBORD_S);
            },
          ),
          ListTile(
            title: Text('Orders'),
            onTap: () {
              Get.toNamed(Routes.ORDER_S);
            },
          ),
          ListTile(
            title: Text('Delivery Notes'),
            onTap: () {
              Get.toNamed(Routes.DELIVERY_S);
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


