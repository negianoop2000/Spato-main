import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';

import '../controllers/general_setting_controller.dart';

class GeneralSettingView extends StatelessWidget {

  final GeneralSettingController controller = Get.put(GeneralSettingController());

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
        title: Text(
          TTexts.txtGeneralSettings,
          style: AppTextStyles.black20.copyWith(fontWeight: FontWeight.w600, color: colorsecondary),
        ),
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
                child: Icon(Icons.arrow_back_ios, color: colorsecondary, size: 15),
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
              TextInputField1(
                height: 50,
                controller: controller.nameController,
                borderColor: borderColor,
                prefixWidget: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 14),
                  child: Text(
                    TTexts.txtClearCache,
                    style: AppTextStyles.black14.copyWith(color: colorsecondary),
                  ),
                ),
                hintText: "Including all data",
                onTap: () {
                  // Handle onTap event
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
