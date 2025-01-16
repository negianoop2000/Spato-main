import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/terms_condition_screen_controller.dart';

class TermsConditionScreenView extends StatelessWidget {
  final controller = Get.put(TermsConditionScreenController());

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

    return Scaffold(
    appBar: AppBar(
        title: Text(
          "Terms and Condition",
          style: AppTextStyles.black20
              .copyWith(fontWeight: FontWeight.w600, color: colorsecondary),
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
      body: Obx(
            () {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return  SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: HtmlWidget(
              controller.termsConditionsText.value,
              onTapUrl: (url) {
                // Handle the URL tap event
                if (url.startsWith("http")) {
                  launchUrl(Uri.parse(url)); // Use url_launcher to open the URL
                }
                return true;
              },
            )

          );
        },
      ),
    );
  }
}