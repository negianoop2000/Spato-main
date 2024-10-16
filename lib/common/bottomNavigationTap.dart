import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/app/modules/home/controllers/home_controller.dart';
import 'package:spato_mobile_app/app/modules/home/views/home_view.dart';
import 'package:spato_mobile_app/app/modules/myCart/controllers/my_cart_controller.dart';
import 'package:spato_mobile_app/app/modules/myCart/views/my_cart_view.dart';
import 'package:spato_mobile_app/app/modules/notification_List_screen/controllers/notification_list_screen_controller.dart';
import 'package:spato_mobile_app/app/modules/notification_List_screen/views/notification_list_screen_view.dart';
import 'package:spato_mobile_app/app/modules/profile_screen/controllers/profile_screen_controller.dart';
import 'package:spato_mobile_app/app/modules/profile_screen/views/profile_screen_view.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/image_strings.dart';
import 'package:badges/badges.dart' as badges;

class BottomNavigationTap extends StatefulWidget {
  final int initialIndex;

  BottomNavigationTap({this.initialIndex = 0});

  @override
  _BottomNavigationTapState createState() => _BottomNavigationTapState();
}

class _BottomNavigationTapState extends State<BottomNavigationTap> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _initializeController(_selectedIndex);
  }

  static List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    MyCartView(),
    NotificationListScreenView(),
    ProfileScreenView(),
  ];

  void _onItemTapped(int index) {
    print("Bottom navigation item tapped: $index"); // Print statement to log the index
    setState(() {
      _selectedIndex = index;
    });
    _initializeController(index);

    switch (index) {
      case 0:
        HomeController homeController = Get.find<HomeController>(tag: 'home');
        homeController.initilize();
        break;
      case 1:
        MyCartController cartController = Get.find<MyCartController>(tag: 'cart');
        cartController.initilize();
        break;
      case 2:
        NotificationListScreenController notificationController = Get.find<NotificationListScreenController>(tag: 'notifications');
        notificationController.fetchNotifications();
        break;
      case 3:
        ProfileScreenController profileController = Get.find<ProfileScreenController>(tag: 'profile');
        profileController.initilize();
        break;
    }
  }

  void _initializeController(int index) {
    switch (index) {
      case 0:
        if (!Get.isRegistered<HomeController>(tag: 'home')) {
          Get.put<HomeController>(
            HomeController(),
            tag: 'home',
          );
        }
        break;
      case 1:
        if (!Get.isRegistered<MyCartController>(tag: 'cart')) {
          Get.put<MyCartController>(
            MyCartController(),
            tag: 'cart',
          );
        }
        break;
      case 2:
        if (!Get.isRegistered<NotificationListScreenController>(tag: 'notifications')) {
          Get.put<NotificationListScreenController>(
            NotificationListScreenController(),
            tag: 'notifications',
          );
        }
        break;
      case 3:
        if (!Get.isRegistered<ProfileScreenController>(tag: 'profile')) {
          Get.put<ProfileScreenController>(
            ProfileScreenController(),
            tag: 'profile',
          );
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final NotificationListScreenController controller = Get.put(NotificationListScreenController());

    Color background = Theme.of(context).brightness == Brightness.light ? TColors.white : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light ? TColors.colorprimaryLight : TColors.darkerGrey;
    Color iconselected = Theme.of(context).brightness == Brightness.light ? TColors.colorprimaryLight : TColors.white;
    Color iconUnselected = Theme.of(context).brightness == Brightness.light ? TColors.colordarkgrey : TColors.colorprimaryLight;

    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: 61,
            decoration: BoxDecoration(
              color: TColors.colorbotttomnavgation,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
              child: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      TImages.imgIconHomeSelect,
                      color: _selectedIndex == 0 ? iconselected : iconUnselected,
                      width: 24,
                      height: 24,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      TImages.imgIconCartUnselect,
                      color: _selectedIndex == 1 ? iconselected : iconUnselected,
                      width: 24,
                      height: 24,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Obx(() {
                      int notificationCount = controller.unreadNotificationCount.value;
                      return badges.Badge(
                        showBadge: notificationCount > 0,
                        badgeContent: Text(
                          notificationCount.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        position: badges.BadgePosition.topEnd(top: -10, end: -12),
                        child: Image.asset(
                          TImages.imgIconNotiUnselect,
                          color: _selectedIndex == 2 ? iconselected : iconUnselected,
                          width: 24,
                          height: 24,
                        ),
                      );
                    }),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      TImages.imgIconmoreunselect,
                      color: _selectedIndex == 3 ? iconselected : iconUnselected,
                      width: 24,
                      height: 24,
                    ),
                    label: '',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.blue,
                onTap: _onItemTapped,
                backgroundColor: TColors.colorbotttomnavgation,
                elevation: 0, // No shadow
              ),
            ),
          ),
        ),
      ),
    );
  }
}

