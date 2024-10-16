import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/common/setting_widget.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';

import '../controllers/policy_screen_controller.dart';

class PolicyScreenView extends GetView<PolicyScreenController> {
  const PolicyScreenView({Key? key}) : super(key: key);
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

    return Scaffold(

      appBar: AppBar(
        title: Text(TTexts.txtPolicies, style: AppTextStyles.black20.copyWith(fontWeight: FontWeight.w600,color: colorsecondary)),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child:  Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: background ,
                  border: Border.all(
                    color: borderColor, // Replace AppColors.CommanGrey
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(Icons.arrow_back_ios,color: colorsecondary,size: 15,),
                )
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              setting_Coustom(
                onTap: () {
                 Get.toNamed(Routes.POLICY_CONDITION);
                },
                svgImage: TImages.imgAccountInfo,
                text: TTexts.txtPrivacyPolicy,
              ),
              setting_Coustom(
                onTap: () {
                Get.toNamed(Routes.TERMS_CONDITION_SCREEN);
                },
                svgImage: TImages.imgAddressBook,
                text: TTexts.txtTermsConditions,
              ),

              setting_Coustom(
                onTap: () {
                  Get.toNamed(Routes.LEGAL);
                },
                svgImage: TImages.imgPolicies,
                text: "Legal Notice",
              ),
              setting_Coustom(
                onTap: () {
                  Get.toNamed(Routes.DELIVERY_CONDITION);
                },
                svgImage: TImages.imggeneral,
                text: "Delivery conditions",
              ),

            ],
          ),
        ),
      ),
    );
  }
}
