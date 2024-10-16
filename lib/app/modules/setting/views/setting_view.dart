import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/common/setting_widget.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';

import '../controllers/setting_controller.dart';

class SettingView extends StatelessWidget {
  final SettingController controller = Get.put(SettingController());

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
    return Scaffold(
      appBar: AppBar(
        title: Text(TTexts.txtSettings,
            style: AppTextStyles.black20.copyWith(
                fontWeight: FontWeight.w600, color: colorsecondary)),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
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
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: colorsecondary,
                    size: 15,
                  ),
                )),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Default_Coustom(
                    onTap: () {
                      Get.toNamed(Routes.ACCOUNT_INFORMATION_SCREEN);
                    },
                    svgImage: TImages.imgAccountInfo,
                    text: TTexts.txtAccountInfo,
                  ),
                  Default_Coustom(
                    onTap: () {
                      Get.toNamed(Routes.NOTIFICATION_SCREEN);
                    },
                    svgImage: TImages.imgNotiifcation,
                    text: TTexts.txtNotifications,
                  ),
                  Default_Coustom(
                    onTap: () {
                      Get.toNamed(Routes.POLICY_SCREEN);
                    },
                    svgImage: TImages.imgPolicies,
                    text: TTexts.txtPolici,
                  ),
                  Default_Coustom(
                    onTap: () {
                      Get.toNamed(Routes.CONTACTUS_SCREEN);
                    },
                    svgImage: TImages.imgHelp,
                    text: TTexts.txtHelp,
                  ),
                  Logout_Coustom(
                    onTap: () {
                      controller.logoutUser();
                    },
                    svgImage: TImages.imgLogout,
                    text: TTexts.txtLogout,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.dialog(
                        AlertDialog(
                          title: Text('Confirm Delete', style: AppTextStyles.black16.copyWith(color: colorsecondary,fontSize: 18)),
                          content: Text('Are you sure you want to delete your account?', style: AppTextStyles.black14.copyWith(color: colorsecondary)),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('Cancel', style: AppTextStyles.black20.copyWith(color: colorsecondary,fontSize: 18)),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back();
                                controller.deleteUser();
                              },
                              child: Text('OK', style: AppTextStyles.black20.copyWith(color: colorsecondary,fontSize: 18)),
                            ),
                          ],
                        ),
                      );
                    },
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
                          leading: Image.asset(
                            "assets/images/delete-user.png",
                            color: Colors.red,
                            height: 30,
                            width: 30,
                          ),
                          title: Text(
                            "Delete account",
                            style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.w500).copyWith(color: TColors.textRed),
                          ),
                          trailing: SvgPicture.asset(TImages.lightArrowForward, color: TColors.textRed), // Arrow icon
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
              child:  ShowLoader.isLoadingProgress(controller.isLoading.value),
            )
          ],
        ),
      ),
    );
  }
}

