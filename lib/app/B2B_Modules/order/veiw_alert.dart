import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:spato_mobile_app/app/B2B_Modules/order/controllers/order.dart';
import 'package:spato_mobile_app/common/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/sizes.dart';




class viewDialog extends StatelessWidget {
  final String auftragsNr;

  const viewDialog({
    super.key,
    required this.auftragsNr,
  });

  @override
  Widget build(BuildContext context) {
    final orderB2BController controller = Get.find<orderB2BController>();

    double screenHeight = AppConstants.getScreenHeight(context);
    double screenWidth = AppConstants.getScreenWidth(context);
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.containerFill
        : TColors.black;
    Color background2 = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: kIsWeb ? 200 : 400,
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(
                    top: 0, left: 0, right: 0, bottom: 0),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: TColors.colorlightgrey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Request a change",
                          style: AppTextStyles.black20
                              .copyWith(fontWeight: FontWeight.w600,),maxLines: 2,textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 0, left: 8, right: 8),
                      child: TextInputField(
                        maxLines: 3,
                        borderColor: borderColor,
                        backgroundColor: background,
                        hintText: "Write here...",
                        hintStyle: TextStyle(color: TColors.colorlightgrey),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        onTap: () {},
                        controller: controller.requestController, // Ensure the controller is used here
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 0, left: 8, right: 8),
                      child: CommonAppButton(
                        color: TColors.colorprimaryLight,
                        width: double.infinity,
                        onPressed: () {

                          controller.requestChange(auftragsNr, controller.requestController.text);
                          Get.back();
                        },
                        buttonText: "Save",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 20, left: 8, right: 8),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: AppTextStyles.black16
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
