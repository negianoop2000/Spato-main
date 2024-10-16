import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';


class ToastClass{
  static const String colorwhite  = '#ffffff';
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
 static showToast(String msg) {
   Get.snackbar(
     msg,
     "",
     // icon: Padding(
     //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
     //   child: Image.asset(
     //     'assets/images/new_logo_toast.png',
     //
     //   ),
     // ),

     snackPosition: SnackPosition.BOTTOM,
     margin: EdgeInsets.all(20),
     isDismissible: true,
     messageText: SizedBox(
       height: 0,
     ),
     padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
     backgroundColor: TColors.containerFill,
     // isDark(Get.context!) ? Colors.white54 : ,
     colorText: isDark(Get.context!) ? Colors.black : Color(0xff027c87),
     forwardAnimationCurve: Curves.easeOut,
     borderRadius: 5.0

   );
 }

}