import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:spato_mobile_app/app/data/model/notification_model.dart';
import '../../../../utils/constants/api_service.dart';

class NotificationListScreenController extends GetxController {
  final count = 0.obs;
  var unreadNotificationCount = 0.obs;
  var isLoading = false.obs;
  List<NotificationModel> notifications = [];

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() async {
    print("Fetching notifications data");
    await notificationsApi();
  }

  Future<void> notificationsApi() async {
    print("Fetching notifications data");
    try {
      isLoading(true);
      var response = await ApiService().notificationsApi();
      if (response != null && response['status'] == "1") {
        var notificationsData = response['data'] as List;
        notifications = notificationsData
            .map((notificationJson) => NotificationModel.fromJson(notificationJson))
            .toList();
        update();
        countUnreadNotifications();
      } else {
        print('Failed to fetch notifications: ${response['message']}');
        Get.snackbar('Error', "Failed to fetch notifications.");
      }
    } catch (e) {
      print('Error fetching notifications data: ${e.toString()}');
      Get.snackbar('Error', "An error occurred while fetching notifications.");
    } finally {
      isLoading(false);
    }
  }

  void countUnreadNotifications() {
    unreadNotificationCount.value = notifications
        .where((notification) => !notification.seenStatus)
        .length;
    update();
  }

  Future<void> readNotification(String id) async {
    try {
      isLoading(true);
      var response = await ApiService().read_notification(id);

      if (response != null && response['status'] == "1" && response['updated_count'] == 1) {
        NotificationModel? notification = notifications.firstWhereOrNull((n) => n.id.toString() == id);
        if (notification != null) {
          notification.toggleSeenStatus();
          countUnreadNotifications();
          update();
        }
      } else {
        Get.snackbar('Error', "Failed to mark notification as read.");
      }
    } catch (e) {
      print('Error reading notification: $e');
      Get.snackbar('Error', "An error occurred while reading the notification.");
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteNotification(String id) async {
    try {
      isLoading(true);
      var response = await ApiService().delete_notification(id);

      if (response != null && response['status'] == "1") {
        notifications.removeWhere((notification) => notification.id.toString() == id);
        countUnreadNotifications();
        update();
      } else {
        Get.snackbar('Error', "Failed to delete notification");
      }
    } catch (e) {
      print('Error in deleting notification: ${e.toString()}');
      Get.snackbar('Error', "An error occurred while deleting the notification.");
    } finally {
      isLoading(false);
    }
  }

  Future<void> onNotificationTap(BuildContext context, NotificationModel notification) async {
    // Mark the notification as read first

    // Use switch case to handle different notification types
    switch (notification.type) {
      case 'coupon':
        await showCouponPopup(context, notification.data);
        await readNotification(notification.id.toString());

        break;

      case 'offer':
      // Handle offer notification
        await readNotification(notification.id.toString());
       // Get.to(() => OfferDetailsScreen(offerId: notification.data));
        break;

      case 'review':
      // Handle review notification
        await readNotification(notification.id.toString());
       // Get.to(() => ReviewDetailsScreen(reviewId: notification.data));
        break;

      case 'order':
      // Handle order notification
        await readNotification(notification.id.toString());
       // Get.to(() => OrderDetailsScreen(orderId: notification.data));
        break;

      default:
        await readNotification(notification.id.toString());
        print('Unknown notification type: ${notification.type}');
        break;
    }
  }

  Future<void> showCouponPopup(BuildContext context, String couponCode) async {
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
                Clipboard.setData(ClipboardData(text: couponCode));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Coupon copied to clipboard!')));
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> showDeleteConfirmation(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Notification'),
          content: Text('Are you sure you want to delete this notification?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
