import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:spato_mobile_app/app/data/country_list.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';

import '../controllers/sign_up_info_controller.dart';

class SignUpInfoView extends StatelessWidget {

  final SignUpInfoController controller = Get.put(SignUpInfoController());
  @override
  Widget build(BuildContext context) {
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey.withOpacity(0.1)
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    Color colorsecondary1 = Theme.of(context).brightness == Brightness.light
        ? Colors.grey.shade600
        : Colors.grey.shade400;

    return Scaffold(
      appBar: AppBar(
        title: Text(TTexts.txtSignup, style: AppTextStyles.black20.copyWith(fontWeight: FontWeight.w600, color: colorsecondary)),
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
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 8, // Adjust padding based on keyboard visibility
          ),
          child: CommonAppButton(
            width: double.infinity,
            color: background,
            borderColor: borderColor,
            onPressed: () {
              controller.validation(context);
            },
            buttonText: TTexts.txtContinue,
            btnTextStyle: AppTextStyles.black20.copyWith(color: colorsecondary),
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() => Stack(
          children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(TTexts.txtAlmost, style: AppTextStyles.Wellcomeheading),
                      Text(TTexts.txtthere, style: AppTextStyles.textHeadingTitle.copyWith(color: colorsecondary)),
                       SizedBox(height: 15),
                      TextInputField(
                        height: 50,
                        borderColor: Colors.grey,
                        backgroundColor: Colors.white,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        controller: controller.userNameController,
                        hintText: "Name",
                        onTap: () {},
                        prefixIcon:  Obx(() => DropdownButton<String>(
                          underline: SizedBox(),
                          value: controller.selectedPrefix.value,
                          items: <String>['Mr.', 'Mrs.']
                              .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style: TextStyle(
                              color: colorsecondary,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),),
                          ))
                              .toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.selectedPrefix.value = newValue;
                              // Update the userNameController with the prefix
                              controller.updateUserNameWithPrefix();
                            }
                          },
                        )),
                      ),
                      SizedBox(height: 20),
                      // IntlPhoneField(
                      //   controller: controller.phoneNumberController,
                      //   keyboardType: TextInputType.phone,
                      //   cursorColor: Colors.black,
                      //   autofocus: false,
                      //   inputFormatters: [
                      //     FilteringTextInputFormatter.digitsOnly,
                      //    // LengthLimitingTextInputFormatter(10),
                      //   ],
                      //   decoration: InputDecoration(
                      //     hintText: TTexts.txtYourNumber,
                      //     hintStyle: TextStyle(
                      //       color: colorsecondary1,
                      //       fontWeight: FontWeight.w400,
                      //       fontSize: 14,
                      //     ),
                      //     contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
                      //     filled: true,
                      //     fillColor: background,
                      //     alignLabelWithHint: true,
                      //     errorStyle: TextStyle(color: Colors.grey.shade400),
                      //     border: OutlineInputBorder(
                      //       borderSide: BorderSide(
                      //         color: TColors.colorlightgrey,
                      //       ),
                      //       borderRadius: BorderRadius.circular(16),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(
                      //         color: TColors.colorlightgrey,
                      //       ),
                      //       borderRadius: BorderRadius.circular(16),
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(
                      //         color: TColors.colorlightgrey,
                      //       ),
                      //       borderRadius: BorderRadius.circular(16),
                      //     ),
                      //     disabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(
                      //         color: TColors.colorlightgrey,
                      //       ),
                      //       borderRadius: BorderRadius.circular(16),
                      //     ),
                      //   ),
                      //   style: AppTextStyles.grey14.copyWith(color: colorsecondary),
                      //   initialCountryCode: "DE", // Set to Germany
                      //   onChanged: (phone) {
                      //     print(phone.completeNumber);
                      //   },
                      //   onCountryChanged: (selectedCountry) {
                      //     controller.countryCode.value = selectedCountry.dialCode ?? "49";
                      //   },
                      //   showDropdownIcon: true,
                      //   showCountryFlag: true,
                      //   dropdownIcon: Icon(Icons.face_3, color: Colors.transparent, size: 12),
                      //   dropdownTextStyle: TextStyle(
                      //     color: colorsecondary,
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      //   invalidNumberMessage: "",
                      //   disableLengthCheck: true,
                      // ),
                      IntlPhoneField(
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        controller: controller.phoneNumberController,
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                      ),

                     // SizedBox(height: 20),
                      TextInputField(
                        height: 50,
                        borderColor: borderColor,
                        backgroundColor: background,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        controller: controller.userCompanyController,
                        hintText: controller.selectedRole.value == 'b2b' || controller.selectedRole.value == 'supplier'
                            ? "Enter Company Name"
                            : "Enter Company Name",
                        onTap: () {controller.isDropdownOpen.value = false;},
                      ),
                      SizedBox(height: 20),
                      TextInputField(
                        height: 50,
                        borderColor: borderColor,
                        backgroundColor: background,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        controller: controller.userVatIdController,
                        hintText: controller.selectedRole.value == 'b2b' || controller.selectedRole.value == 'supplier'
                            ? "Enter VAT ID"
                            : "Enter VAT ID",
                        onTap: () {controller.isDropdownOpen.value = false;},
                      ),

                      SizedBox(height: 20),
                      Row(
                        children: [
                          SvgPicture.asset(TImages.imgSignuphome),
                          SizedBox(width: 8,),
                          Text(TTexts.txtSetupAddress, style: AppTextStyles.black16.copyWith(fontWeight: FontWeight.w600, color: colorsecondary)),
                        ],
                      ),
                      SizedBox(height: 20),
                      TextInputField(
                        height: 50,
                        borderColor: borderColor,
                        backgroundColor: background,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        controller: controller.streetnameController,
                        hintText: TTexts.txtenterstreetname,
                        onTap: () {controller.isDropdownOpen.value = false;},
                      ),
                      SizedBox(height: 20),
                      TextInputField(
                        height: 50,
                        borderColor: borderColor,
                        backgroundColor: background,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        controller: controller.streetnumberController,
                        hintText: TTexts.txtenterstreetnumber,
                        onTap: () {controller.isDropdownOpen.value = false;},
                      ),
                      SizedBox(height: 20),
                      TextInputField(
                        height: 50,
                        borderColor: borderColor,
                        backgroundColor: background,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        controller: controller.userCityController,

                        hintText: "Enter City",
                        onTap: () {controller.isDropdownOpen.value = false;},
                      ),
                      SizedBox(height: 20),
                      TextInputField(
                        height: 50,
                        readOnly: true,
                        cursorColor: Colors.transparent,
                        controller: controller.userCountryController,
                        borderColor: Colors.grey,
                        backgroundColor: Colors.white,
                        hintText: 'Select Country',
                        suffixIconWidget: IconButton(
                          icon: Icon(controller.isDropdownOpen.value
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,color: colorsecondary,),
                          onPressed: () {
                            controller.isDropdownOpen.value =
                            !controller.isDropdownOpen.value;
                          },
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        onTap: () {
                          controller.isDropdownOpen.value = true;
                        },
                      ),
                      if (controller.isDropdownOpen.value)
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: TColors.colorprimaryLight.withOpacity(.10),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Scrollbar(
                            child: ListView(
                              children: CountryList.countries.map((country) {
                                return ListTile(
                                  title: Text(country,style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),),
                                  onTap: () {
                                    controller.selectedCountry.value = country;
                                    controller.userCountryController.text =
                                        controller.selectedCountry.value;
                                    controller.isDropdownOpen.value = false;
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      // TextInputField(
                      //   height: 50,
                      //   borderColor: borderColor,
                      //   backgroundColor: background,
                      //   enabledBorder: InputBorder.none,
                      //   focusedBorder: InputBorder.none,
                      //   controller: controller.userCountryController,
                      //   hintText: "Enter Country",
                      //   onTap: () {},
                      // ),
                      SizedBox(height: 20),
                      TextInputField(
                        height: 50,
                        borderColor: borderColor,
                        backgroundColor: background,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        controller: controller.userPincodeController,
                        hintText: "Enter ZIP Code",
                        onTap: () {controller.isDropdownOpen.value = false;},
                      ),

                      SizedBox(height: 20),

                      TextInputField(
                        height: 50,
                        borderColor: borderColor,
                        backgroundColor: background,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        controller: controller.userReferralController,
                        hintText: "Enter Referral Number If have",
                        onTap: () {controller.isDropdownOpen.value = false;},
                      ),
                      SizedBox(height: 20),
                      Text("Select Your Role", style: AppTextStyles.black16.copyWith(fontWeight: FontWeight.w600, color: colorsecondary)),
                      SizedBox(height: 20),
                  Obx(() {
                    return Column(
                      children: [
                        RadioListTile(
                          title: Text("Normal",style: AppTextStyles.black16.copyWith(fontWeight: FontWeight.w600, color: colorsecondary)),
                          value: "Normal",
                          activeColor: borderColor,
                          groupValue: controller.selectedRole.value,
                          onChanged: (value) {
                            controller.toggleRole(value as String);
                          },
                        ),
                        RadioListTile(
                          title: Text("B2B",style: AppTextStyles.black16.copyWith(fontWeight: FontWeight.w600, color: colorsecondary)),
                          value: "b2b",
                          activeColor: borderColor,
                          groupValue: controller.selectedRole.value,
                          onChanged: (value) {
                            controller.toggleRole(value as String);
                          },
                        ),
                        RadioListTile(
                          title: Text("Supplier",style: AppTextStyles.black16.copyWith(fontWeight: FontWeight.w600, color: colorsecondary)),
                          value: "supplier",
                          activeColor: borderColor,
                          groupValue: controller.selectedRole.value,
                          onChanged: (value) {
                            controller.toggleRole(value as String);
                          },
                        ),
                      ],
                    );
                  }),]
                ),
              ),
                    ),
            ],
          ),
        ),
      ) );
  }
}


