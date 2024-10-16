import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';

import '../controllers/forget_password_otp_screen_controller.dart';

class ForgetPasswordOtpScreenView extends StatelessWidget {

 final ForgetPasswordOtpScreenController controller = Get.put(ForgetPasswordOtpScreenController());

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
        TTexts.txtOtpVerification,
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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              TTexts.txtEnterotpnumber,
              style: AppTextStyles.textHeadingTitle.copyWith(color: TColors.colorlightgrey, fontSize: 13),
            ),
            Text(
              "ellen123@gmail.com",
              style: AppTextStyles.textHeadingTitle.copyWith(color: colorsecondary, fontSize: 13),
            ),
            SizedBox(height: 20),
            GetBuilder<ForgetPasswordOtpScreenController>(
                builder: (controller) =>   Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: PinCodeTextField(
                      controller: controller.pinController,
                      appContext: context,
                      length: 4,
                      onChanged: (pin) {
                        controller.enteredPin = pin;
                        controller.showErrors = false;
                        // Simulating delay in error display
                        Future.delayed(Duration(seconds: 2), () {
                          controller.showErrors = false;
                        });
                      },
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      textStyle: AppTextStyles.heading1,
                      enableActiveFill: true,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        fieldHeight: 60,
                        fieldWidth: MediaQuery.of(context).size.width * 0.18,
                        borderRadius: BorderRadius.circular(10.0),
                        activeFillColor: TColors.coloractivepinbox.withOpacity(0.1),
                        selectedFillColor: TColors.coloractivepinbox.withOpacity(0.1),
                        inactiveFillColor: TColors.coloractivepinbox.withOpacity(0.1),
                        activeColor: TColors.colordarkgrey,
                        inactiveColor: TColors.colorlightgrey,
                        selectedColor: TColors.colordarkgrey,
                      ),
                      cursorColor: TColors.colorprimaryLight,
                    ),
                ),),

            SizedBox(height: 20),
            CommonAppButton(
              color: TColors.colorprimaryLight,
              width: double.infinity,
              onPressed: () {
                controller.verifyCode();
                if (controller.isCodeVerified) {
                  Get.toNamed(Routes.CREATE_PASSWORD);
                }
              },
              buttonText: TTexts.txtSubmit,
            ),
          ],
        ),
      ),
    ),
  );
}
}