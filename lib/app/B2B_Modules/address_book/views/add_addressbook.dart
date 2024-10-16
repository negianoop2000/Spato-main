import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/app/B2B_Modules/address_book/controllers/addressbook.dart';
import 'package:spato_mobile_app/app/data/country_list.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/common/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';




class Add_addressBookView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final AddressbookB2BController controller = Get.find<AddressbookB2BController>();
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
                              Text(
                                "Name",
                                style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                              ),
                              SizedBox(height: 5),
                              TextInputField(
                              //  readOnly: true,
                                height: 50,
                                controller: controller.repeatUserNameController,
                                borderColor: borderColor,
                                backgroundColor: background,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: TTexts.txttypefirstname,
                               // cursorColor: Colors.transparent,
                                onTap: () {

                                },

                              ),
                              SizedBox(height: 15,),
                              Text(
                                "Phone",
                                style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                              ),
                              SizedBox(height: 5),
                              TextInputField(
                              //  readOnly: true,
                                height: 50,
                                controller: controller.phoneNumberController,
                                borderColor: borderColor,
                                backgroundColor: background,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: TTexts.txttypeyournumber,
                              keyboardType: TextInputType.phone,
                              //  cursorColor: Colors.transparent,
                                onTap: () {

                                },

                              ),
                              SizedBox(height: 15,),
                              Text(
                                "Email",
                                style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                              ),
                              SizedBox(height: 5),
                              TextInputField(
                                height: 50,
                                controller: controller.emailControler,
                                borderColor: borderColor,
                                backgroundColor: background,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: TTexts.txttypeyouremail,
                             //   readOnly: true,
                             //   cursorColor: Colors.transparent,
                                onTap: () {

                                },

                              ),


                              SizedBox(height: 15,),
                              Text(
                                "Street",
                                style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                              ),
                              SizedBox(height: 5),
                              TextInputField(
                                height: 50,
                                controller: controller.addressController,
                                borderColor: borderColor,
                                backgroundColor: background,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,

                                hintText: "type your street",
                                onTap: () {
                                },

                              ),

                              SizedBox(height: 15,),
                              Text(
                                "Number",
                                style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                              ),
                              SizedBox(height: 5),
                              TextInputField(
                                height: 50,
                                controller: controller.streetNumberController,
                                borderColor: borderColor,
                                backgroundColor: background,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,

                                hintText: "type your street number",
                                onTap: () {
                                },

                              ),
                              SizedBox(height: 15,),
                              Text(
                                TTexts.txtPostalCode,
                                style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                              ),
                              SizedBox(height: 5),
                              TextInputField(
                                height: 50,
                                controller: controller.zipCodeController,
                                borderColor: borderColor,
                                backgroundColor: background,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                keyboardType: TextInputType.numberWithOptions(),
                                hintText:  TTexts.txttypeyourpostalcode,
                                onTap: () {

                                },

                              ),

                              SizedBox(height: 15,),
                              Text(
                                TTexts.txtCity,
                                style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                              ),
                              SizedBox(height: 5),
                              TextInputField(
                                height: 50,
                                controller: controller.cityController,
                                borderColor: borderColor,
                                backgroundColor: background,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,

                                hintText: TTexts.txttypeyourcity,
                                onTap: () {

                                },

                              ),
                              SizedBox(height: 15,),
                              Text(
                                TTexts.txtcountry,
                                style: AppTextStyles.textFieldTitle.copyWith(color: colorsecondary),
                              ),
                              SizedBox(height: 5),
                              TextInputField(
                                height: 50,
                                readOnly: true,
                                cursorColor: Colors.transparent,
                                controller: controller.countryController,
                                borderColor: Colors.grey,
                                backgroundColor: Colors.white,
                                hintText: "type your country",
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

                              SizedBox(height: 15,),




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
}
