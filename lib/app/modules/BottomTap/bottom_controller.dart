import 'package:get/get.dart';
import 'package:spato_mobile_app/app/modules/home/views/home_view.dart';
import 'package:spato_mobile_app/app/modules/myCart/views/my_cart_view.dart';
import 'package:spato_mobile_app/app/modules/notification_List_screen/views/notification_list_screen_view.dart';
import 'package:spato_mobile_app/app/modules/profile_screen/views/profile_screen_view.dart';

class BottomNavigationController extends GetxController {
  var selectedIndex = 0.obs;

  final widgetOptions = [
    HomeView(),
    MyCartView(),
    NotificationListScreenView(),
    ProfileScreenView(),
  ].obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
