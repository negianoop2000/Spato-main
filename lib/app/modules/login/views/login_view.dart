import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/common/bottomNavigationTap.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';

import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey.withOpacity(0.1)
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    Color createAnAcount = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.colorsecondaryDark;
    Color bottomAcountText = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.colorprimaryLight;

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Obx (()=> Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TTexts.txtWelcome,
                        style: AppTextStyles.textHeadingTitle.copyWith(color: TColors.colorprimaryLight),
                      ),
                      Text(
                        TTexts.txtback,
                        style: AppTextStyles.textHeadingTitle.copyWith(color: colorsecondary),
                      ),
                      Text(
                        TTexts.txtSignMsg,
                        style: AppTextStyles.textTitleLight.copyWith(color: TColors.colorlightgrey, fontSize: 13),
                      ),
                      SizedBox(height: 10),
                      TextInputField(
                        height: 50,
                        controller: controller.emailController,
                        borderColor: borderColor,
                        backgroundColor: background,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusNode: controller.emailFocusNode,
                        prefixIcon: SvgPicture.asset(
                          TImages.imgIconEmail, // Replace with your SVG path
                          color: controller.emailController.text.isEmpty
                              ? TColors.colordarkgrey
                              : TColors.colorlightgrey,
                          height: 16,
                          width: 16,
                        ),
                        hintText: TTexts.txtEntermail,
                        onTap: () {},
                      ),
                      SizedBox(height: 15),
                      TextInputField(
                        height: 50,
                        borderColor: borderColor,
                        backgroundColor: background,
                        focusNode: controller.passwordFocusNode,
                        controller: controller.passwordController,
                        isObsecure: !controller.isPasswordVisible.value,
                        prefixIcon: SvgPicture.asset(
                          TImages.imgIconPassword,
                          color: controller.passwordController.text.isEmpty
                              ? TColors.colordarkgrey
                              : TColors.colorlightgrey,
                        ),
                        suffixIconWidget: GestureDetector(
                          onTap: controller.togglePasswordVisibility,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: SvgPicture.asset(
                              controller.isPasswordVisible.value
                                  ? "assets/icons/vissible.svg"
                                  : "assets/icons/inVissible.svg",
                              color: controller.passwordController.text.isEmpty
                                  ? TColors.colordarkgrey
                                  : TColors.colorlightgrey,
                            ),
                          ),
                        ),
                        hintText: TTexts.txtEnterpassword,
                        onTap: () {},
                      ),
                      SizedBox(height: 20), // Add some spacing
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.toggleRememberMe();
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                  color: TColors.colorprimaryLight,
                                  width: 1,
                                ),
                                color: controller.rememberMe.value
                                    ? TColors.colorprimaryLight
                                    : Colors.transparent,
                              ),
                              child: controller.rememberMe.value
                                  ? Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              )
                                  : null,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            TTexts.txtRemberme,
                            style: AppTextStyles.textTitleLight.copyWith(color: TColors.colorprimaryLight),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                             Get.toNamed(Routes.FORGET_PASSWORD);
                            },
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                TTexts.txtforgotpassword,
                                style: AppTextStyles.textTitleLight.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: TColors.colorprimaryLight,
                                  color: TColors.colorprimaryLight,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      CommonAppButton(
                        color: TColors.colorprimaryLight,
                        width: double.infinity,
                        onPressed: () {
                        controller.validation(context);
                        //   Get.offAll(() => BottomNavigationTap());
                        },
                        buttonText: TTexts.txtSignin,
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                           FocusScope.of(context).unfocus();
                         Get.toNamed(Routes.SIGN_UP_INFO);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              TTexts.txtDontaccount,
                              style: AppTextStyles.textTitleLight.copyWith(
                                decorationColor: bottomAcountText,
                                color: bottomAcountText,
                              ),
                            ),
                            Text(
                              TTexts.txtCreateanaccount,
                              style: AppTextStyles.textTitleLight.copyWith(
                                decorationColor: TColors.colorprimaryLight,
                                color: TColors.colorprimaryLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
                child:  ShowLoader.isLoadingProgress(controller.isLoading.value),
              )
            ],
          ),
        ),
      ),
    );
  }
}