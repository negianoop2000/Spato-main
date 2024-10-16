import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';

import '../controllers/add_new_address_screen_controller.dart';

class AddNewAddressScreenView extends GetView<AddNewAddressScreenController> {
  AddNewAddressScreenView({Key? key}) : super(key: key);
  final AddNewAddressScreenController controller = Get.put(AddNewAddressScreenController());

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
          'Add New Address',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: colorsecondary,
          ),
        ),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => TextInputField1(
                height: 50,
                controller: controller.areaController.value,
                borderColor: borderColor,
                backgroundColor: background,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixWidget: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 14),
                  child: Text(
                    'Area',
                    style: TextStyle(
                      fontSize: 14,
                      color: colorsecondary,
                    ),
                  ),
                ),
                hintText: 'Select the province',
                onTap: () {},
              )),
              SizedBox(height: 8),
              Obx(() => TextInputField1(
                height: 50,
                controller: controller.fullanmeController.value,
                borderColor: borderColor,
                backgroundColor: background,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixWidget: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 14),
                  child: Text(
                    'Full Name',
                    style: TextStyle(
                      fontSize: 14,
                      color: colorsecondary,
                    ),
                  ),
                ),
                hintText: 'Input Name',
                onTap: () {},
              )),
              SizedBox(height: 8),
              Obx(() => TextInputField1(
                height: 50,
                controller: controller.mobileController.value,
                borderColor: borderColor,
                backgroundColor: background,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixWidget: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 14),
                  child: Text(
                    'Mobile Number',
                    style: TextStyle(
                      fontSize: 14,
                      color: colorsecondary,
                    ),
                  ),
                ),
                hintText: 'Input Number',
                onTap: () {},
              )),
              SizedBox(height: 8),
              Obx(() => TextInputField1(
                height: 50,
                controller: controller.birthdayController.value,
                borderColor: borderColor,
                backgroundColor: background,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixWidget: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 14),
                  child: Text(
                    'Birthday',
                    style: TextStyle(
                      fontSize: 14,
                      color: colorsecondary,
                    ),
                  ),
                ),
                hintText: 'Address',
                onTap: () {},
              )),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: borderColor,
                  ),
                ),
                child: ListTile(
                  leading: Text(
                    'Default Delivery Address',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colorsecondary,
                    ),
                  ),
                  trailing: Obx(() => Switch(
                    value: controller.isNotificationEnabled.value,
                    activeTrackColor: Color(0xff81d8d0),
                    inactiveTrackColor: Color(0xff81d8d0),
                    activeColor: Colors.black,
                    inactiveThumbColor: Colors.black,
                    hoverColor: Colors.transparent,
                    onChanged: (newValue) {
                      controller.toggleNotification(newValue);
                    },
                  )),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: borderColor,
                  ),
                ),
                child: ListTile(
                  leading: Text(
                    'Default Billing Address',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colorsecondary,
                    ),
                  ),
                  trailing: Obx(() => Switch(
                    value: controller.isNotificationEnabled.value,
                    activeTrackColor: Color(0xff81d8d0),
                    inactiveTrackColor: Color(0xff81d8d0),
                    activeColor: Colors.black,
                    inactiveThumbColor: Colors.black,
                    hoverColor: Colors.transparent,
                    onChanged: (newValue) {
                      controller.toggleNotification(newValue);
                    },
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
