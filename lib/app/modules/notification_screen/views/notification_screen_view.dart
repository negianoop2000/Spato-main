import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';

import '../controllers/notification_screen_controller.dart';

class NotificationScreenView extends GetView<NotificationScreenController> {
  NotificationScreenView({Key? key}) : super(key: key);
  final NotificationScreenController controller = Get.put(NotificationScreenController());

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
    Color trackColor = Theme.of(context).brightness == Brightness.light
        ? Color(0xff81d8d0)
        : Color(0xff88cbcd);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 20,
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
            children: [
              Obx(() => Container(
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
                    'Push All Notifications',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  trailing: Switch(
                    value: controller.isNotificationEnabledAll.value,
                    activeTrackColor: trackColor,
                    inactiveTrackColor: trackColor,
                    activeColor: textColor,
                    inactiveThumbColor: textColor,
                    hoverColor: Colors.transparent,
                    onChanged: (newValue) {
                      controller.toggleNotificationAll();
                    },
                  ),
                ),
              )),
              // SizedBox(height: 20),
              // Obx(() => Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: background,
              //     borderRadius: BorderRadius.circular(15),
              //     border: Border.all(
              //       color: borderColor,
              //     ),
              //   ),
              //   child: ListTile(
              //     leading: Text(
              //       'Promotions',
              //       style: TextStyle(
              //         fontSize: 14,
              //         fontWeight: FontWeight.w500,
              //         color: textColor,
              //       ),
              //     ),
              //     trailing: Switch(
              //       value: controller.isNotificationEnabledPromotions.value,
              //       activeTrackColor: trackColor,
              //       inactiveTrackColor: trackColor,
              //       activeColor: textColor,
              //       inactiveThumbColor: textColor,
              //       hoverColor: Colors.transparent,
              //       onChanged: (newValue) {
              //         controller.toggleNotificationPromotions(newValue);
              //       },
              //     ),
              //   ),
              // )),
              // SizedBox(height: 20),
              // Obx(() => Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: background,
              //     borderRadius: BorderRadius.circular(15),
              //     border: Border.all(
              //       color: borderColor,
              //     ),
              //   ),
              //   child: ListTile(
              //     leading: Text(
              //       'Orders',
              //       style: TextStyle(
              //         fontSize: 14,
              //         fontWeight: FontWeight.w500,
              //         color: textColor,
              //       ),
              //     ),
              //     trailing: Switch(
              //       value: controller.isNotificationEnabledOrders.value,
              //       activeTrackColor: trackColor,
              //       inactiveTrackColor: trackColor,
              //       activeColor: textColor,
              //       inactiveThumbColor: textColor,
              //       hoverColor: Colors.transparent,
              //       onChanged: (newValue) {
              //         controller.toggleNotificationOrders(newValue);
              //       },
              //     ),
              //   ),
              // )),
              // SizedBox(height: 20),
              // Obx(() => Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: background,
              //     borderRadius: BorderRadius.circular(15),
              //     border: Border.all(
              //       color: borderColor,
              //     ),
              //   ),
              //   child: ListTile(
              //     leading: Text(
              //       'Alerts & Reminders',
              //       style: TextStyle(
              //         fontSize: 14,
              //         fontWeight: FontWeight.w500,
              //         color: textColor,
              //       ),
              //     ),
              //     trailing: Switch(
              //       value: controller.isNotificationEnabledAlerts.value,
              //       activeTrackColor: trackColor,
              //       inactiveTrackColor: trackColor,
              //       activeColor: textColor,
              //       inactiveThumbColor: textColor,
              //       hoverColor: Colors.transparent,
              //       onChanged: (newValue) {
              //         controller.toggleNotificationAlerts(newValue);
              //       },
              //     ),
              //   ),
              // )),
            ],
          ),
        ),
      ),
    );
  }
}