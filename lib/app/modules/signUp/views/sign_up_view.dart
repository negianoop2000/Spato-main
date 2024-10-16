import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    Color colorsecondary = Get.theme.brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Get.theme.brightness == Brightness.light
        ? TColors.containerFillDark
        : TColors.black;
    Color borderColor = Get.theme.brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    Color bottomAcountText = Get.theme.brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.colorprimaryLight;

    return Scaffold(
      appBar: AppBar(
        title: Text(TTexts.txtSignup,
            style: AppTextStyles.black20.copyWith(
                fontWeight: FontWeight.w600, color: colorsecondary)),
        leading: InkWell(
          onTap: () {
            Get.back();
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
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx (()=> Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(TTexts.txtHello,
                          style: AppTextStyles.textHeadingTitle
                              .copyWith(color: TColors.colorprimaryLight)),
                      SizedBox(height: 2),
                      Text(TTexts.txtthere,
                          style: AppTextStyles.textHeadingTitle.copyWith(
                              color: colorsecondary)),
                      SizedBox(height: 10),
                      Text(TTexts.txtSignMsg,
                          style: AppTextStyles.textTitleLight.copyWith(
                              color: TColors.colorlightgrey, fontSize: 13)),
                      SizedBox(height: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextInputField(
                            height: 50,
                            controller: signUpController.emailController,
                            borderColor: borderColor,
                            backgroundColor: background,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            prefixIcon: SvgPicture.asset(
                              TImages.imgIconEmail,color: colorsecondary,
                            ),
                            hintText: "Enter your mail",
                            onTap: () {},
                          ),
                          SizedBox(height: 12),
                          Obx(
                                () => TextInputField(
                              height: 50,
                              controller: signUpController.passwordController,
                              borderColor: borderColor,
                              backgroundColor: background,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isObsecure: !signUpController.isPasswordVisible.value,
                              prefixIcon: SvgPicture.asset(
                                TImages.imgIconPassword,color: colorsecondary,
                              ),
                              suffixIconWidget: GestureDetector(
                                onTap: signUpController.togglePasswordVisibility,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: SvgPicture.asset(
                                    signUpController.isPasswordVisible.value
                                        ? "assets/icons/vissible.svg"
                                        : "assets/icons/inVissible.svg",color: colorsecondary,
                                  ),
                                ),
                              ),
                              hintText: "Create Password",
                              onTap: () {},
                            ),
                          ),

                          SizedBox(height: 12),
                          Obx(
                                () =>TextInputField(
                              height: 50,
                              controller: signUpController.retypepasswordController,
                              borderColor: borderColor,
                              backgroundColor: background,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                                  isObsecure: !signUpController.isRePasswordVisible.value,
                              prefixIcon: SvgPicture.asset(
                                TImages.imgIconPassword,color: colorsecondary,
                              ),
                              suffixIconWidget: GestureDetector(
                                onTap: signUpController.toggleRePasswordVisibility,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: SvgPicture.asset(
                                    signUpController.isRePasswordVisible.value
                                        ? "assets/icons/vissible.svg"
                                        : "assets/icons/inVissible.svg",color: colorsecondary,
                                  ),
                                ),
                              ),
                              hintText: "Re-type password",
                              onTap: () {},
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  signUpController.toggleAgreeToTerms();
                                },
                                child: Obx(() => Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.0),
                                    border: Border.all(
                                      color: TColors.colorprimaryLight,
                                      width: 1,
                                    ),
                                    color: signUpController.agreeCheckBox.value
                                        ? TColors.colorprimaryLight
                                        : Colors.transparent,
                                  ),
                                  child: signUpController.agreeCheckBox.value
                                      ? Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                      : null,
                                )),
                              ),
                              SizedBox(width: 15),
                              GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  // Navigate or handle terms agreement logic
                                },
                                child: Align(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          TTexts.txtAgreeTo,
                                          style: AppTextStyles.textTitleLight.copyWith(
                                              decorationColor: TColors.colorprimaryLight,
                                              color: TColors.colorlightgrey,
                                              fontSize: 12),
                                        ),
                                        GestureDetector(onTap: (){
                                          Get.toNamed(Routes.TERMS_CONDITION_SCREEN);
                                        },
                                          child: Text(
                                            TTexts.txtTermsOf,
                                            style: AppTextStyles.textTitleLight.copyWith(
                                                decoration: TextDecoration.underline,
                                                decorationColor: TColors.colorlightgrey,
                                                color: TColors.colorlightgrey,
                                                fontSize: 12),
                                          ),
                                        ),
                                        Text(
                                          TTexts.txtand,
                                          style: AppTextStyles.textTitleLight.copyWith(
                                              decorationColor: TColors.colorlightgrey,
                                              color: TColors.colorlightgrey,
                                              fontSize: 12),
                                        ),
                                        GestureDetector(onTap: (){
                                          Get.toNamed(Routes.POLICY_CONDITION);
                                        },
                                          child: Text(
                                            TTexts.txtPrivacypolicy,
                                            style: AppTextStyles.textTitleLight.copyWith(
                                                decoration: TextDecoration.underline,
                                                decorationColor: TColors.colorlightgrey,
                                                color: TColors.colorlightgrey,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          CommonAppButton(
                            color: TColors.colorprimaryLight,
                            width: double.infinity,
                            onPressed: () {
                              signUpController.validation(context);
                            //  Get.toNamed(Routes.SIGN_UP_INFO);
                            },
                            buttonText: TTexts.txtSignup,
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                Get.toNamed(Routes.LOGIN);
                              },
                              child: Align(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        TTexts.txtAlreadyhavean,
                                        style: AppTextStyles.textTitleLight.copyWith(
                                          decorationColor: bottomAcountText,
                                          color: bottomAcountText,
                                        ),
                                      ),
                                      Text(
                                        TTexts.txtSignin,
                                        style: AppTextStyles.textTitleLight.copyWith(
                                          decorationColor: TColors.colorprimaryLight,
                                          color: TColors.colorprimaryLight,
                                        ),
                                      ),
                                    ],
                                  ))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
                child:  ShowLoader.isLoadingProgress(signUpController.isLoading.value),
              )
            ],
          ),
        ),
      ),
    );
  }
}