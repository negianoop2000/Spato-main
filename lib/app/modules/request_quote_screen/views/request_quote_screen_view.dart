import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/common/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';
import 'package:spato_mobile_app/utils/helpers/countrypic/intl_phone_field.dart';

import '../controllers/request_quote_screen_controller.dart';



class RequestQuoteScreenView extends StatelessWidget {
  final RequestQuoteScreenController controller = Get.put(RequestQuoteScreenController());

  @override
  Widget build(BuildContext context) {
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color colorsecondary1 = Theme.of(context).brightness == Brightness.light
        ? Colors.grey.shade600
        : Colors.grey.shade400;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey.withOpacity(0.1)
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;

    return Scaffold(
      appBar: AppBar(
        title: Text(TTexts.txtRequestQuote, style: AppTextStyles.black20.copyWith(fontWeight: FontWeight.w600, color: colorsecondary)),
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
                child: Icon(Icons.arrow_back_ios, color: colorsecondary, size: 15),
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx (()=> Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TTexts.txtCompanyName,
                        style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                      ),
                      TextInputField(
                        height: 50,
                        controller: controller.companyNameController,
                        borderColor: borderColor,
                        backgroundColor: background,
                        hintText: TTexts.txttypeyourcompanyname,
                        hintStyle: TextStyle(color: colorsecondary1),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        onTap: () {},
                      ),
                      SizedBox(height: 20),
                      Text(
                        TTexts.txtContactName,
                        style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                      ),
                      TextInputField(
                        height: 50,
                        controller: controller.contactNameController,
                        borderColor: borderColor,
                        backgroundColor: background,
                        hintStyle: TextStyle(color: colorsecondary1),
                        hintText: TTexts.txttypeyourname,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        onTap: () {},
                      ),
                      SizedBox(height: 20),
                      Text(
                        TTexts.txtEmail,
                        style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                      ),
                      TextInputField(
                        height: 50,
                        controller: controller.emailController,
                        borderColor: borderColor,
                        backgroundColor: background,
                        hintStyle: TextStyle(color: colorsecondary1),
                        hintText: "type your email...",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        onTap: () {},
                      ),
                      SizedBox(height: 20),
                      Text(
                        TTexts.txtPhoneNumber,
                        style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                      ),
                      IntlPhoneField(
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        cursorColor: Colors.black,
                        autofocus: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          // LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: InputDecoration(
                          hintText: "type your number...",
                          hintStyle: TextStyle(
                            color: colorsecondary1,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
                          filled: true,
                          fillColor: background,
                          alignLabelWithHint: true,
                          errorStyle: TextStyle(color: Colors.grey.shade400),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: TColors.colorlightgrey,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: TColors.colorlightgrey,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: TColors.colorlightgrey,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: TColors.colorlightgrey,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        style: AppTextStyles.grey14.copyWith(color: colorsecondary),
                        initialCountryCode: "DE", // Set to Germany
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                        onCountryChanged: (selectedCountry) {
                          controller.countryCode.value = selectedCountry.dialCode ?? "49";
                        },
                        showDropdownIcon: true,
                        showCountryFlag: true,
                        dropdownIcon: Icon(Icons.face_3, color: Colors.transparent, size: 12),
                        dropdownTextStyle: TextStyle(
                          color: colorsecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        invalidNumberMessage: "",
                        disableLengthCheck: true,
                      ),
                      // TextInputField(
                      //   height: 50,
                      //   controller: controller.phoneController,
                      //   borderColor: borderColor,
                      //   backgroundColor: background,
                      //   hintStyle: TextStyle(color: c),
                      //   hintText: TTexts.txttypeyourphone,
                      //   enabledBorder: InputBorder.none,
                      //   focusedBorder: InputBorder.none,
                      //   inputFormatters: [
                      //     FilteringTextInputFormatter.digitsOnly,
                      //     LengthLimitingTextInputFormatter(10),
                      //   ],
                      //   onTap: () {},
                      // ),
                      SizedBox(height: 20),
                      Text(
                        TTexts.txtSparePartName,
                        style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                      ),
                      TextInputField(
                        height: 50,
                        controller: controller.sparePartsController,
                        borderColor: borderColor,
                        backgroundColor: background,
                        hintStyle: TextStyle(color: colorsecondary1),
                        hintText: TTexts.txttypesparepartname,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        onTap: () {},
                      ),
                      SizedBox(height: 20),
                      Text(
                        TTexts.txtQuoteNeededBy,
                        style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                      ),
                      TextInputField(
                        height: 50,
                        controller: controller.quoteNeededController,
                        borderColor: borderColor,
                        backgroundColor: background,
                        hintStyle: TextStyle(color: colorsecondary1),
                        hintText: TTexts.txttypequote,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        onTap: () {},
                      ),
                      // SizedBox(height: 20),
                      // Text(
                      //   TTexts.txtProjectBudgetStatus,
                      //   style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                      // ),
                      // buildBudgetOption(context, TTexts.txtReleased),
                      // SizedBox(height: 20),
                      // buildBudgetOption(context, TTexts.txtAppropalPending),
                      // SizedBox(height: 20),
                      // buildBudgetOption(context, TTexts.txtOpen),
                      // SizedBox(height: 20),
                      // buildBudgetOption(context, TTexts.txtNoAppopal),

                      SizedBox(height: 20),
                      Text(
                        "Brief Overview",
                        style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                      ),
                      TextFormField(
                        controller: controller.briefOverviewController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: background,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: borderColor
                              )
                          ),
                          focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(

                                  color: borderColor
                              )
                          ),
                          hintStyle: TextStyle(color: colorsecondary1),
                          hintText: "type here...",
                        ),
                        maxLines: 6,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Upload Document",
                        style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                      ),
                      InkWell(onTap: () => controller.pickFile(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: borderColor)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/upload.svg",color: colorsecondary,
                                ),
                                SizedBox(width: 10,),
                                Obx(() {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Display "Edit File" if a file is selected, otherwise "Choose File"
                                      Text(
                                        controller.selectedFile.value != null
                                            ? "Edit File"
                                            : "Choose File",
                                        style: TextStyle(
                                          color: colorsecondary1,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 4), // Spacing between the texts
                                      // Display the file name in bold if a file is selected
                                      Text(
                                        controller.selectedFile.value != null
                                            ? controller.selectedFile.value!.path.split('/').last
                                            : "You can attach file(jpg,jpeg,png,gif)",
                                        style: TextStyle(
                                          color: colorsecondary1,
                                          fontSize: 12,
                                          fontWeight: controller.selectedFile.value != null
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  );
                                }),

                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      CommonAppButton(
                        color: TColors.colorprimaryLight,
                        width: double.infinity,
                        onPressed: () {
                          controller. validation(context);
                        },
                        buttonText: "Continue",
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

  Widget buildBudgetOption(BuildContext context, String title) {
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey.withOpacity(0.1)
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;

    return Obx(() {
      bool isSelected = controller.selectedBudgetOption.value == title;
      return GestureDetector(
        onTap: () {
          controller.selectedBudgetOption.value = title;
        },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: background,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              SizedBox(width: 24 ,),
              Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  color: background,
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: isSelected
                    ? Center(
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: borderColor,
                    ),
                  ),
                )
                    : SizedBox.shrink(),
              ),
              SizedBox(width: 12),
              Text(title, style: AppTextStyles.textFieldTitle.copyWith(color: isSelected
                  ? colorsecondary : TColors.colordarkgrey )),
            ],
          ),
        ),
      );
    });
  }
}


