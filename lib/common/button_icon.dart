import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';

class BtnIcon_Coustom extends StatelessWidget {
  final VoidCallback onTap;
  final String svgImage;
  final String text;

  const BtnIcon_Coustom({
    required this.onTap,
    required this.svgImage,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: TColors.colorlightbackground,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: TColors.colorlightgrey,
            ),
          ),
          child: ListTile(
            leading: SvgPicture.asset(svgImage),
            title: Text(text, style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.w500).copyWith(color: TColors.colorprimaryLight)),
            // Arrow icon
          ),
        ),
      ),
    );
  }
}