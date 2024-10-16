import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/app_text_styles.dart';
import '../../../../utils/constants/colors.dart';
import '../../../data/model/notification_model.dart';
import '../controllers/notification_list_screen_controller.dart';
import 'notification_item.dart';

class NotificationListScreenView extends StatelessWidget {
  NotificationListScreenView({super.key});

  final NotificationListScreenController controller = Get.put(NotificationListScreenController());

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
        title: Text('Notifications', style: AppTextStyles.black20.copyWith(fontWeight: FontWeight.w600, color: colorsecondary)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            if (controller.notifications.isEmpty) {
              return Center(child: Text("No notifications available."));
            }

            return ListView.builder(
              itemCount: controller.notifications.length,
              itemBuilder: (context, index) {
                final notification = controller.notifications[index];

                return Dismissible(
                  key: Key(notification.id.toString()),
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    return await controller.showDeleteConfirmation(context);
                  },
                  onDismissed: (direction) async {
                    await controller.deleteNotification(notification.id.toString());
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Notification deleted')));
                  },
                  child: NotificationItem(
                    notification: notification,
                    onTap: () {
                      controller.onNotificationTap(context, notification);
                    },
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }

  Future<void> _showCouponPopup(BuildContext context, String couponCode) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Coupon Code'),
          content: Text('Use this code: $couponCode'),
          actions: [
            TextButton(
              child: Text('Copy'),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: couponCode)); // Copy coupon code to clipboard
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Coupon copied to clipboard!')));
                Navigator.of(context).pop(); // Close the popup
              },
            ),
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
              },
            ),
          ],
        );
      },
    );
  }
}
