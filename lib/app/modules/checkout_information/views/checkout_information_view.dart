import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/app/data/country_list.dart';
import 'package:spato_mobile_app/common/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';

import '../controllers/checkout_information_controller.dart';

class CheckoutInformationView extends StatelessWidget {
  final CheckoutInformationController controller = Get.put(CheckoutInformationController());

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
          title: Text("Add Address", style: AppTextStyles.black20.copyWith(fontWeight: FontWeight.w600,color: colorsecondary)),
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child:  Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: background ,
                    border: Border.all(
                      color: borderColor, // Replace AppColors.CommanGrey
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(Icons.arrow_back_ios,color: colorsecondary,size: 15,),
                  )
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Obx(() =>  Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   "Name",
                                //   style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                                // ),
                                // const SizedBox(height: 5),
                                // TextInputField(
                                //   height: 50,
                                //   controller: controller.repeatUserNameController,
                                //   borderColor: borderColor,
                                //   backgroundColor: background,
                                //   focusedBorder: InputBorder.none,
                                //   enabledBorder: InputBorder.none,
                                //   hintText: TTexts.txttypefirstname,
                                //
                                //   onTap: () {
                                //
                                //   },
                                //
                                // ),
                                // const SizedBox(height: 15,),
                                // Text(
                                //   "Phone",
                                //   style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                                // ),
                                // const SizedBox(height: 5),
                                // IntlPhoneField(
                                //   decoration: const InputDecoration(
                                //     labelText: 'Phone Number',
                                //     labelStyle: TextStyle(color: Colors.grey),
                                //     border: OutlineInputBorder(
                                //       borderSide: BorderSide(),
                                //     ),
                                //   ),
                                //   controller: controller.phoneNumberController,
                                //   initialCountryCode: 'DE',
                                //   onChanged: (phone) {
                                //     print(phone.completeNumber);
                                //   },
                                // ),

                               // SizedBox(height: 15,),
                               //  Text(
                               //    "Email",
                               //    style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                               //  ),
                               //  const SizedBox(height: 5),
                               //  TextInputField(
                               //    height: 50,
                               //    controller: controller.emailControler,
                               //    borderColor: borderColor,
                               //    backgroundColor: background,
                               //    focusedBorder: InputBorder.none,
                               //    enabledBorder: InputBorder.none,
                               //    hintText: TTexts.txttypeyouremail,
                               //    onTap: () {
                               //
                               //    },
                               //
                               //  ),
                               //
                               //  const SizedBox(height: 15,),

                              //  if (controller.usertype.value == "b2b") ...[
                                  _buildInputField("Company Name", controller.companynameController, "Enter Company Name",colorsecondary,background,borderColor),
                                  _buildInputField("Company Phone", controller.companyphoneController, "Enter Company Phone",colorsecondary,background,borderColor, isNumber: true),
                                  _buildInputField("Company Email", controller.companyemailController, "Enter Company Email",colorsecondary,background,borderColor),
                              //  ],

                                _buildInputField("Address", controller.addressController, "Address",colorsecondary,background,borderColor),
                                _buildInputField(TTexts.txtPostalCode, controller.zipCodeController, TTexts.txttypeyourpostalcode,colorsecondary,background,borderColor,isNumber: true),
                                _buildInputField(TTexts.txtCity, controller.cityController, TTexts.txttypeyourcity,colorsecondary,background,borderColor),

                                const SizedBox(height: 15,),
                                Text(
                                  TTexts.txtcountry,
                                  style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                                ),
                                const SizedBox(height: 5),
                                // Create a new TextField for inputting country names
                                TextField(
                                  focusNode: controller.countryFocusNode, // FocusNode to detect focus
                                  readOnly: false,
                                  cursorColor: Colors.transparent,
                                  controller: controller.countryController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: TTexts.txttypeyourcountry,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.isDropdownOpen.value ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                        color: colorsecondary,
                                      ),
                                      onPressed: () {
                                        controller.isDropdownOpen.value = !controller.isDropdownOpen.value;
                                      },
                                    ),
                                  ),
                                  onTap: () {
                                    // Open the dropdown when the TextField is tapped
                                    if (!controller.isDropdownOpen.value) {
                                      controller.isDropdownOpen.value = true;
                                    }
                                  },
                                  onChanged: (value) {
                                    // Update the filteredCountries list based on the input value
                                    if (value.isEmpty) {
                                      controller.filteredCountries.assignAll(CountryList.countries); // Reset to all countries
                                    } else {
                                      controller.filteredCountries.assignAll(CountryList.countries.where((country) {
                                        return country.toLowerCase().contains(value.toLowerCase());
                                      }).toList());
                                    }
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
                                        children: controller.filteredCountries.map((country) {
                                          return ListTile(
                                            title: Text(
                                              country,
                                              style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                                            ),
                                            onTap: () {
                                              controller.selectedCountry.value = country;
                                              controller.countryController.text = controller.selectedCountry.value;
                                              controller.isDropdownOpen.value = false;

                                              // Unfocus the TextField after selection
                                              controller.countryFocusNode.unfocus();
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),

                                const SizedBox(height: 15,),
                                CommonAppButton(
                                  color: TColors.colorprimaryLight,
                                  width: double.infinity,
                                  onPressed: () {
                                    controller.validation();
                                  },
                                  buttonText: "Add Address",

                                ),
                              ],
                            ),
                            //  ]
                            //),
                          ]
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
                    child:  ShowLoader.isLoadingProgress(controller.isLoading.value),
                  )
                ],
              ),
            )));
  }


  Widget _buildInputField(String title, TextEditingController controller, String hintText,  Color colorsecondary,Color background, Color borderColor,{bool isNumber = false} ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
        ),
        const SizedBox(height: 5),
        TextInputField(
          height: 50,
          controller: controller,
          borderColor: borderColor,
          backgroundColor: background,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: hintText,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          onTap: () {},
        ),
        const SizedBox(height: 15),
      ],
    );
  }

}
