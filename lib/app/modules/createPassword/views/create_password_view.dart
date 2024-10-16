import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';

import '../controllers/create_password_controller.dart';
class CreatePasswordView extends StatelessWidget {

  final CreatePasswordController controller = Get.put(CreatePasswordController());

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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          TTexts.txtCreatepassword,
          style: AppTextStyles.black20.copyWith(fontWeight: FontWeight.w600, color: colorsecondary),
        ),
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
        child: Obx( () => Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      TTexts.txtPleaseCreateNew,
                      style: AppTextStyles.textHeadingTitle.copyWith(color: colorsecondary, fontSize: 25),
                    ),
                    SizedBox(height: 20),
                    Obx(() => TextInputField(
                      height: 50,
                      controller: controller.newPasswordController,
                      borderColor: borderColor,
                      backgroundColor: background,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      isObsecure: !controller.isPasswordVisible.value,
                      prefixIcon: SvgPicture.asset(
                        TImages.imgIconPassword,
                      ),
                      suffixIconWidget: GestureDetector(
                        onTap: controller.togglePasswordVisibility,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: SvgPicture.asset(
                            controller.isPasswordVisible.value
                                ? "assets/icons/vissible.svg"
                                : "assets/icons/inVissible.svg",
                          ),
                        ),
                      ),
                      hintText: TTexts.txtPleaseEnterPassword,
                      onTap: () {},
                    )),

                    SizedBox(height: 15),
                    Obx(
                            () => TextInputField(
                      height: 50,
                      controller: controller.confirmPasswordController,
                      borderColor: TColors.colorsecondaryLight,
                      backgroundColor: TColors.colorlightgrey.withOpacity(0.1),
                      isObsecure: !controller.isRePasswordVisible.value,
                      prefixIcon: SvgPicture.asset(
                        TImages.imgIconPassword,
                      ),
                      suffixIconWidget: GestureDetector(
                        onTap: controller.toggleRePasswordVisibility,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: SvgPicture.asset(
                            controller.isRePasswordVisible.value
                                ? "assets/icons/vissible.svg"
                                : "assets/icons/inVissible.svg",
                          ),
                        ),
                      ),
                      hintText: TTexts.txtPleaseEnterConfirmPassword,
                      onTap: () {},
                    )),
                    SizedBox(height: 20),
                    Obx(() => CommonAppButton(
                      color: TColors.colorprimaryLight,
                      width: double.infinity,
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                        controller.submit();
                      },
                      buttonText: controller.isLoading.value ? 'Loading...' : TTexts.txtSubmit,
                    )),
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
      ),
    );
  }
}