import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/common/bottomNavigationTap.dart';

import '../utils/constants/app_text_styles.dart';
import '../utils/constants/colors.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colorSecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.containerFill
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    return AppBar(
      leading: InkWell(
        onTap: () {
              Get.offAll(() => BottomNavigationTap(initialIndex: 3));
            },
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: background,
              border: Border.all(
                color: borderColor,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(Icons.arrow_back_ios, color: colorSecondary, size: 15),
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.black20.copyWith(fontWeight: FontWeight.w600, color: colorSecondary),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
