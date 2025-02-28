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
        ? 'assets/logos/spato_logo_light.png'
        : 'assets/logos/spato_logo_dark.png';
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
