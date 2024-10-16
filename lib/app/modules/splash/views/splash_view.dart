import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';

import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  final controller = Get.put(SplashController());


  @override
  Widget build(BuildContext context) {
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.containerFillDark
        : TColors.black;
    String imagePath = Theme.of(context).brightness == Brightness.light
        ? 'assets/images/Splash Screen_light.png'
        : 'assets/images/Splash Screen_dark.png';
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Image.asset(imagePath),
      ),
    );
  }
}
