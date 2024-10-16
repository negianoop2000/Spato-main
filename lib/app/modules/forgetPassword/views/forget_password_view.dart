import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';

import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends StatelessWidget {
  final ForgetPasswordController controller = Get.put(ForgetPasswordController());

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
          TTexts.txtforgotpassword,
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
        child: Obx(
            ()=> Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GetBuilder<ForgetPasswordController>(
                  builder: (controller) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        TTexts.txtPleaseEnterEmail,
                        style: AppTextStyles.textHeadingTitle.copyWith(color: colorsecondary, fontSize: 25),
                      ),

                      SizedBox(height: 20),

                      TextInputField(
                        height: 50,
                        controller: controller.emailController,
                        borderColor: borderColor,
                        backgroundColor: background,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        prefixIcon: SvgPicture.asset(
                          TImages.imgIconEmail,
                        ),
                        hintText: TTexts.txtEntermail,
                        onTap: () {},
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      CommonAppButton(
                        color: TColors.colorprimaryLight,
                        width: double.infinity,
                        onPressed: () {
                          controller.validation(context);
                          },
                        buttonText: TTexts.txtSubmit,
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