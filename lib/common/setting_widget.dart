import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';

class Default_Coustom extends StatelessWidget {
  final VoidCallback onTap;
  final String svgImage;
  final String text;

  const Default_Coustom({
    required this.onTap,
    required this.svgImage,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.containerFill
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: borderColor,
            ),
          ),
          child: ListTile(
            leading: SvgPicture.asset(svgImage,color: colorsecondary,),
            title: Text(text, style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.w500,color: colorsecondary)),
            trailing: SvgPicture.asset(TImages.lightArrowForward,color: colorsecondary,),
          ),
        ),
      ),
    );
  }
}

class Logout_Coustom extends StatelessWidget {
  final VoidCallback onTap;
  final String svgImage;
  final String text;

  const Logout_Coustom({
    required this.onTap,
    required this.svgImage,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.containerFill
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: borderColor,
            ),
          ),
          child: ListTile(
            leading: SvgPicture.asset(svgImage),
            title: Text(text, style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.w500).copyWith(color: TColors.textRed)),
            trailing: SvgPicture.asset(TImages.lightArrowForward,color: TColors.textRed), // Arrow icon
          ),
        ),
      ),
    );
  }
}

class setting_Coustom extends StatelessWidget {
  final VoidCallback onTap;
  final String svgImage;
  final String text;

  const setting_Coustom({
    required this.onTap,
    required this.svgImage,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.containerFillDark
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    Color textColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colordarkgrey
        : TColors.white;
    Color trakColor = Theme.of(context).brightness == Brightness.light
        ? Color(0xff81d8d0)
        : Color(0xff88cbcd);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: borderColor,
            ),
          ),
          child: ListTile(
            leading: SvgPicture.asset(svgImage,color: textColor,),
            title: Text(text, style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.w500,color: textColor)),
            trailing: SvgPicture.asset(TImages.lightArrowForward,color: textColor,), // Arrow icon
          ),
        ),
      ),
    );
  }
}