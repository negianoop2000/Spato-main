import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/Custom%20Widget/country_selector.dart';
import 'package:spato_mobile_app/app/data/country_list.dart';
import 'package:spato_mobile_app/common/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';
import 'package:spato_mobile_app/utils/helpers/countrypic/intl_phone_field.dart';

import '../controllers/editProfile_controller.dart';
class editProfileView extends StatelessWidget {

  final editProfileController controller = Get.put(editProfileController());

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text(TTexts.txtEditProfile, style: AppTextStyles.black20.copyWith(fontWeight: FontWeight.w600, color: colorsecondary)),
        leading: InkWell(
          onTap: () {
            Get.back(result: true);
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
                child: Icon(Icons.arrow_back_ios, color: colorsecondary, size: 15,),
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() => Stack(
          children: [
            GestureDetector(onTap: () {
              controller.isDropdownOpen.value = false;
            },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () => controller.showImagePicker(context),
                          child: Obx(
                                () => Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: TColors.containerFill,
                                shape: BoxShape.circle,
                              ),
                              child: controller.image.value == null
                                  ? ClipOval(
                                    child: CachedNetworkImage(
                                                                  imageUrl: "${ApiService.imageUrl}${controller.userImage.value}",
                                                                  placeholder: (context, url) => Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                                                  ),
                                                                  errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                                                                  fit: BoxFit.cover,
                                                                ),
                                  )
                                  : ClipOval(
                                child: Image.file(
                                  controller.image.value!,
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "${TTexts.txtFullName}",
                        style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                      ),
                      TextInputField(
                        height: 50,
                        controller: controller.repeatUserNameController,
                        borderColor: borderColor,
                        backgroundColor: background,
                        hintStyle: TextStyle(color: TColors.colorlightgrey),
                        hintText: TTexts.txtFullName,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        onTap: () { controller.isDropdownOpen.value = false;},
                      ),
                      SizedBox(height: 20),
                      Text(
                        "${TTexts.txtPhoneNumber}",
                        style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                      ),
                      // TextInputField(
                      //   height: 50,
                      //   controller: controller.phoneNumberController,
                      //   borderColor: borderColor,
                      //   backgroundColor: background,
                      //   hintStyle: TextStyle(color: TColors.colorlightgrey),
                      //   hintText: TTexts.txttypeyourphone,
                      //   enabledBorder: InputBorder.none,
                      //   focusedBorder: InputBorder.none,
                      //   inputFormatters: [
                      //     FilteringTextInputFormatter.digitsOnly,
                      //     LengthLimitingTextInputFormatter(10),
                      //   ],
                      //   onTap: () { controller.isDropdownOpen.value = false;},
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


                      SizedBox(height: 20),
                      Text(
                        "${TTexts.txtStreetname}",
                        style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                      ),
                      TextInputField(
                        height: 50,
                        controller: controller.streetnameController,
                        borderColor: borderColor,
                        backgroundColor: background,
                        hintStyle: TextStyle(color: TColors.colorlightgrey),
                        hintText: TTexts.txtAddress,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        onTap: () { controller.isDropdownOpen.value = false;},
                      ),
                      SizedBox(height: 20),

                      Text(
                        "${TTexts.txtStreetnumber}",
                        style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                      ),
                      TextInputField(
                        height: 50,
                        controller: controller.streetnumberController,
                        borderColor: borderColor,
                        backgroundColor: background,
                        hintStyle: TextStyle(color: TColors.colorlightgrey),
                        hintText: TTexts.txtAddress,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        onTap: () { controller.isDropdownOpen.value = false;},
                      ),
                      SizedBox(height: 20),
                      Text(
                        TTexts.txtCity,
                        style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                      ),
                      TextInputField(
                        height: 50,
                        controller: controller.cityController,
                        borderColor: borderColor,
                        backgroundColor: background,
                        hintText: TTexts.txtCity,
                        hintStyle: TextStyle(color: TColors.colorlightgrey),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        onTap: () { controller.isDropdownOpen.value = false;},
                      ),
                      SizedBox(height: 20),
                      Text(
                        TTexts.txtzipCode,
                        style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                      ),
                      TextInputField(
                        height: 50,
                        controller: controller.zipCodeController,
                        borderColor: borderColor,
                        backgroundColor: background,
                        hintStyle: TextStyle(color: TColors.colorlightgrey),
                        hintText: TTexts.txtzipCode,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        onTap: () { controller.isDropdownOpen.value = false;},
                      ),
                      SizedBox(height: 20),
                      Text(
                        TTexts.txtcountry,
                        style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                      ),
                      TextInputField(
                        height: 50,
                        readOnly: true,
                        cursorColor: Colors.transparent,
                        controller: controller.countryController,
                        borderColor: Colors.grey,
                        backgroundColor: Colors.white,
                        hintText: TTexts.txtcountry,
                        suffixIconWidget: IconButton(
                          icon: Icon(controller.isDropdownOpen.value ? Icons.arrow_drop_up : Icons.arrow_drop_down,color: colorsecondary,),
                          onPressed: () {
                            controller.isDropdownOpen.value = !controller.isDropdownOpen.value;
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
                                    controller.countryController.text = controller.selectedCountry.value;
                                    controller.isDropdownOpen.value = false;

                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),

                      SizedBox(height: 20),
                      Text(
                        TTexts.txtvat_number,
                        style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                      ),
                      TextInputField(
                        height: 50,
                        controller: controller.vatNumberController,
                        borderColor: borderColor,
                        backgroundColor: background,
                        hintStyle: TextStyle(color: TColors.colorlightgrey),
                        hintText: TTexts.txtvat_number,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        onTap: () { controller.isDropdownOpen.value = false;},
                      ),
                      SizedBox(height: 20),
                      CommonAppButton(
                        color: TColors.colorprimaryLight,
                        width: double.infinity,
                        onPressed: () {
                          controller.validateFields();
                        },
                        buttonText: "Update",
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
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
