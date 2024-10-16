import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../app/data/model/category_productList.dart';
import '../app/modules/notification_List_screen/views/notification_list_screen_view.dart';
import '../app/routes/app_pages.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Request notification permission
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }
    } else {
      if (kDebugMode) {
        print('User denied permission');
      }
    }
  }

  // Get FCM Token
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    print("FCM Token: $token");
    return token!;
  }

  // Initialize local notifications for showing notifications in the foreground
  void initLocalNotifications(BuildContext context, RemoteMessage message) async {
    var androidSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
          // Handle notification tap when app is active
          handleMessage(context, message);
        });
  }

  // Listen to FCM messages in different app states
  void firebaseInit(BuildContext context) {
    // Foreground state
    FirebaseMessaging.onMessage.listen((message) {
      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      } else if (Platform.isIOS) {
        forgroundMessage();
      }
    });
  }

  // Listen to FCM messages when the app is in background or terminated
  Future<void> setupInteractMessage(BuildContext context) async {
    // Background state
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });

    // Terminated state
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null && message.data.isNotEmpty) {
        handleMessage(context, message);
      }
    });
  }

  // Show notification in the foreground
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.max,
      playSound: true,
    );

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Your channel description',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _flutterLocalNotificationsPlugin.show(
      notificationId,
      message.notification!.title.toString(),
      message.notification!.body.toString(),
      notificationDetails,
      payload: 'my_data',
    );
  }

  // Show notification for iOS in the foreground
  Future<void> forgroundMessage() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // Handle notification taps and navigate accordingly
  Future<void> handleMessage(BuildContext context, RemoteMessage message) async {
    print("Handling message with data: ${message.data}");
    if (message.data["location"] == "details") {
      List<dynamic> productData = jsonDecode(message.data["product"]);
      List<ProductList> products = productData.map((item) => ProductList.fromJson(item)).toList();
      Get.toNamed(Routes.DETAIL_SCREEN, arguments: {'products': products, 'index': 0});
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationListScreenView(),
        ),
      );
    }
  }
}
