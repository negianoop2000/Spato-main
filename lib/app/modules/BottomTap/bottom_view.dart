import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'bottom_controller.dart';


class BottomNavigationTap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BottomNavigationController controller = Get.find<BottomNavigationController>();

    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.white
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorprimaryLight
        : TColors.darkerGrey;
    Color iconselected = Theme.of(context).brightness == Brightness.light
        ? TColors.colorprimaryLight
        : TColors.white;
    Color iconUnselected = Theme.of(context).brightness == Brightness.light
        ? TColors.colordarkgrey
        : TColors.colorprimaryLight;

    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        body: Obx(() => Center(
          child: controller.widgetOptions[controller.selectedIndex.value],
        )),
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
              child: Obx(() => BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      TImages.imgIconHomeSelect,
                      color: controller.selectedIndex.value == 0 ? iconselected : iconUnselected,
                      width: 24,
                      height: 24,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      TImages.imgIconCartUnselect,
                      color: controller.selectedIndex.value == 1 ? iconselected : iconUnselected,
                      width: 24,
                      height: 24,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      TImages.imgIconNotiUnselect,
                      color: controller.selectedIndex.value == 2 ? iconselected : iconUnselected,
                      width: 24,
                      height: 24,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      TImages.imgIconmoreunselect,
                      color: controller.selectedIndex.value == 3 ? iconselected : iconUnselected,
                      width: 24,
                      height: 24,
                    ),
                    label: '',
                  ),
                ],
                currentIndex: controller.selectedIndex.value,
                selectedItemColor: Colors.blue,
                onTap: controller.changeIndex,
                backgroundColor: TColors.colorbotttomnavgation,
                elevation: 0, // No shadow
              )),
            ),
          ),
        ),
      ),
    );
  }
}
