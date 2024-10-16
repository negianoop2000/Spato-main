import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';

import '../controllers/account_information_screen_controller.dart';


class AccountInformationScreenView extends GetView<AccountInformationScreenController> {
  const AccountInformationScreenView({Key? key}) : super(key: key);

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
        title: Text(
          'Account Information',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: colorsecondary,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back(); // Use GetX navigation method
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
        child: Obx ( () => Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextInputField1(
                      readOnly: true,
                      cursorColor: Colors.transparent,
                      height: 50,
                      controller: controller.nameController,
                      borderColor: borderColor,
                      backgroundColor: background,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      keyboardType: TextInputType.none,
                      prefixWidget: Padding(
                        padding: const EdgeInsets.only(left: 12, top: 14),
                        child: Text(
                          'Full Name',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      hintText: 'Full Name',

                      onTap: () {},
                    ),
                    SizedBox(height: 8),
                    TextInputField1(
                      readOnly: true,
                      cursorColor: Colors.transparent,
                      height: 50,
                      controller: controller.emailController,
                      borderColor: borderColor,
                      backgroundColor: background,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      keyboardType: TextInputType.none,
                      prefixWidget: Padding(
                        padding: const EdgeInsets.only(left: 12, top: 14),
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 14,
                            color: colorsecondary,
                          ),
                        ),
                      ),

                      hintText: 'ellen123@gmail.com',
                      onTap: () {},
                    ),
                  ],
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
