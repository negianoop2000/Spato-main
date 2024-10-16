import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/contactus_screen_controller.dart';

class ContactusScreenView extends GetView<ContactusScreenController> {
  const ContactusScreenView({Key? key}) : super(key: key);

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
        title: Text(TTexts.txtContactus,
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        launch("tel:+491703475912");
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: background,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: borderColor,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: TColors.colorlightgrey,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: TColors.colorbotttomnavgationDark,
                                        border: Border.all(
                                          color: borderColor,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.phone,
                                          color: textColor,
                                          size: 25,
                                        ),
                                      )),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                TTexts.txtCallUs,
                                style: AppTextStyles.black20.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: textColor),
                              ),
                              SizedBox(height: 8),
                              Text(
                                TTexts.txtAvailableMonday,
                                style: AppTextStyles.grey14.copyWith(
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        launch("mailto:info@spato.de"); // Corrected URI
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: background,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: borderColor,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: TColors.colorlightgrey,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: TColors.colorbotttomnavgationDark,
                                        border: Border.all(
                                          color: borderColor,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.email,
                                          color: textColor,
                                          size: 25,
                                        ),
                                      )),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Mail Us",
                                style: AppTextStyles.black20.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: textColor),
                              ),
                              SizedBox(height: 8),
                              Text(
                                TTexts.txtAvailableMonday,
                                style: AppTextStyles.grey14.copyWith(
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
