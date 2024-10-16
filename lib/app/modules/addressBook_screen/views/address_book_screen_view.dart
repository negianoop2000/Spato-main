import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/common/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';

import '../controllers/address_book_screen_controller.dart';

class AddressBookScreenView extends GetView<AddressBookScreenController> {
  const AddressBookScreenView({Key? key}) : super(key: key);
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
        title: Text("Address Book", style: AppTextStyles.black20.copyWith(fontWeight: FontWeight.w600,color: colorsecondary)),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
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
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed(Routes.ADD_NEW_ADDRESS_SCREEN);
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return ProductDialog();
              //   },
              // );
            },
            child: Text("Add", style: AppTextStyles.grey16.copyWith(color: TColors.colorprimaryLight)),
          ),
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: background, // Replace AppColors.containerFill
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: borderColor, // Replace AppColors.CommanGrey
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Ellen",style: AppTextStyles.black16.copyWith(fontWeight: FontWeight.w500,color: colorsecondary),),

                          Spacer(),
                          Text("Edit", style: AppTextStyles.grey16),

                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            flex:1,
                            child: CommonAppButton(
                              height: 30,
                              color: TColors.containerFill,
                              borderColor: Color(0xff81d8d8),
                              btnTextStyle: AppTextStyles.grey12,
                              onPressed: () {
                                //     Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotpasswordScreen(),));
                              },
                              buttonText: "Home",

                            ),
                          ),
                          SizedBox(width: 4,),
                          Expanded(flex: 3,
                            child: CommonAppButton(
                              height: 30,width: double.infinity,
                              color: TColors.containerFill,
                              borderColor: Color(0xff81d8d8),
                              btnTextStyle: AppTextStyles.grey12,
                              onPressed: () {
                                //     Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotpasswordScreen(),));
                              },
                              buttonText: "Default delivery & billing address",

                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Text("\u2022", style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.normal)),
                          SizedBox(width: 8,),      Text("Street: Flotowstr. 63", style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.w400,color: colorsecondary)),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text("\u2022", style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.normal)),
                          SizedBox(width: 8,),   Text("City: Lengefeld", style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.w400,color: colorsecondary)),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text("\u2022", style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.normal)),
                          SizedBox(width: 8,),   Text("State/province/area: Freistaat Sachsen", style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.w400,color: colorsecondary)),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text("\u2022", style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.normal)),
                          SizedBox(width: 8,),    Text("Phone number: 03464 59 20 78", style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.w400,color: colorsecondary)),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text("\u2022", style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.normal)),
                          SizedBox(width: 8,),   Text("Zip code: 09512", style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.w400,color: colorsecondary)),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text("\u2022", style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.normal)),
                          SizedBox(width: 8,),   Text("Country calling code: +49", style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.w400,color: colorsecondary)),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text("\u2022", style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.normal)),
                          SizedBox(width: 8,),
                          Text("Country: Germany", style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.w400,color: colorsecondary)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
