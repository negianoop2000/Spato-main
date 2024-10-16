import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';
import 'package:url_launcher/url_launcher.dart';

import 'legal_controller.dart';



class WordDocView extends GetView<WordDocController> {
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
          "Legal Notice",
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Legal Notice\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text: "SPATO GmbH\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text:
                    "Schellberger Weg 34\n42659 Solingen Germany\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "Contact:\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text: "Email: info@spato.de\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "Represented by the Managing Director:\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text:
                    "Mr. Oliver Laug, contact details as above\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "Commercial Register:\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text:
                    "Register Court: Wuppertal District Court\nRegistration Number: HRB 32131\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "VAT ID:\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text: "DE346441844\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "Content Responsibility:\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text:
                    "Mr. Oliver Laug, contact details as above\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text:
                    "The European Commission provides an online dispute resolution (ODR) platform, which can be accessed via the following link: ",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "https://ec.europa.eu/consumers/odr.\n\n",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launch("https://ec.europa.eu/consumers/odr");
                      },
                  ),
                  TextSpan(
                    text:
                    "This platform serves as a point of contact for out-of-court settlements of disputes arising from online purchase or service contracts involving a consumer. We are neither obliged nor willing to participate in a dispute resolution procedure before a consumer arbitration board.\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text:
                    "However, we would like to point out that our direct purchase offer currently targets business customers only.\n\n",
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

