import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/common/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';

import '../controllers/checkout_payment_controller.dart';

class CheckoutPaymentView extends GetView<CheckoutPaymentController> {
  const CheckoutPaymentView({Key? key}) : super(key: key);
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

    TextEditingController usernameController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController cvvController = TextEditingController();

    return Scaffold(


        appBar: AppBar(
          title: Text(TTexts.txtCheckout, style: AppTextStyles.black20.copyWith(fontWeight: FontWeight.w600,color: colorsecondary)),
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
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Add some spacing

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: TColors.colorprimaryLight),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color: TColors.colorprimaryLight,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text("Information", style: AppTextStyles.textTitleMediumSemi.copyWith(color: TColors.colorprimaryLight,fontSize: 15)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      border: Border.all(color:  TColors.colorprimaryLight),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color:  TColors.colorprimaryLight,
                                          borderRadius: BorderRadius.circular(4),
                                        ),

                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text("Shipping", style: AppTextStyles.textTitleMediumSemi.copyWith(color: TColors.colorprimaryLight,fontSize: 15)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      border: Border.all(color:  TColors.colorlightgrey),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color:  TColors.colorlightgrey,
                                          borderRadius: BorderRadius.circular(4),
                                        ),

                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text("Payment", style: AppTextStyles.textTitleMediumSemi.copyWith(color: TColors.colorlightgrey,fontSize: 15)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TTexts.txtPaymentMethod,
                            style: AppTextStyles.textTitleMedium.copyWith(color: colorsecondary,fontSize: 20),
                          ),
                          SizedBox(height: 10,),
                          TextInputField(
                            height: 50,
                            controller: usernameController,
                            borderColor: borderColor,
                            backgroundColor: background,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            prefixIcon: SvgPicture.asset(
                              TImages.imgunselectPayment,
                            ),
                            hintText: TTexts.txtCashondelivery,
                            hintStyle: TextStyle(color: colorsecondary),
                            onTap: () {

                            },

                          ),
                          SizedBox(height: 15,),

                          TextInputField(
                            height: 50,
                            controller: usernameController,
                            borderColor: borderColor,
                            backgroundColor: background,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintStyle: TextStyle(color: colorsecondary),
                            prefixIcon: SvgPicture.asset(
                              TImages.imgunselectPayment,
                            ),
                            hintText: TTexts.txtPaypal,
                            onTap: () {

                            },

                          ),

                          SizedBox(height: 15,),

                          TextInputField(
                            height: 50,
                            controller: usernameController,
                            borderColor: borderColor,
                            backgroundColor: background,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintStyle: TextStyle(color: colorsecondary),
                            prefixIcon: SvgPicture.asset(
                              TImages.imgunselectPayment,
                            ),
                            hintText: TTexts.txtDebitCreditCard,
                            onTap: () {

                            },

                          ),

                          SizedBox(height: 15,),
                          Text(
                            TTexts.txtCardNumber,
                            style: AppTextStyles.textTitleMedium.copyWith(color: colorsecondary,fontSize: 17),
                          ),
                          SizedBox(height: 10,),
                          TextInputField(
                            height: 50,
                            controller: usernameController,
                            borderColor: borderColor,
                            backgroundColor: background,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintStyle: TextStyle(color: colorsecondary),
                            hintText: TTexts.txttypeyournumber,
                            onTap: () {

                            },

                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Valid Date",
                                        style:  AppTextStyles.textTitleMedium.copyWith(color: colorsecondary,fontSize: 17),
                                      ),
                                      SizedBox(height: 10,),
                                      TextInputField(
                                        height: 50,
                                        controller: dateController,
                                        borderColor: borderColor,
                                        backgroundColor: background,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        hintStyle: TextStyle(color: colorsecondary),
                                        hintText: "",
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "CVV/CVC",
                                        style:  AppTextStyles.textTitleMedium.copyWith(color: colorsecondary,fontSize: 17,),
                                      ),
                                      SizedBox(height: 10,),
                                      TextInputField(
                                        height: 50,
                                        controller: cvvController,
                                        borderColor: borderColor,
                                        backgroundColor: background,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        hintStyle: TextStyle(color: colorsecondary),
                                        hintText: "",
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),




                          CommonAppButton(
                            color: TColors.colorprimaryLight,
                            width: double.infinity,
                            onPressed: () {
                           Get.toNamed(Routes.CHECKOUT_CONGRATULATION);
                            },
                            buttonText: TTexts.txtPayNow,

                          ),







                        ],
                      ),
                      //  ]
                      //),
                    ]
                ),
              ),
            )));
  }
}
