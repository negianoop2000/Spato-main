import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/utils/Connectivity.dart';
import 'package:spato_mobile_app/utils/theme/theme.dart';
import 'app/routes/app_pages.dart';
import 'common/language_helper.dart';
import 'firebase_services/fcmservice.dart';
import 'firebase_services/notification_service.dart';
import 'utils/constants/text_strings.dart';

// Global Navigator Key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Background message handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyCDKSytCnZbWvIJzbE8mG1aqcOEuPsPy8I',
        appId: '1:566627742789:android:0eb48f534de0f84d74df2c',
        messagingSenderId: '566627742789',
        projectId: 'notification-for-android-485',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  print('Handling a background message ${message.messageId}');
}

// HTTP Overrides for invalid certificates
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCDKSytCnZbWvIJzbE8mG1aqcOEuPsPy8I',
        appId: '1:566627742789:android:0eb48f534de0f84d74df2c',
        messagingSenderId: '566627742789',
        projectId: 'notification-for-android-485',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await _initializeGuestToken();

  // Retrieve saved language
  //String savedLanguage = await LanguageHelper.getSavedLanguage();
 // Locale initialLocale = Locale(savedLanguage);

  runApp(MyApp(
    //  initialLocale: initialLocale
  ));
}

class MyApp extends StatefulWidget {
 // final Locale initialLocale;

 // MyApp({required this.initialLocale});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    FcmService.firebaseInit();

    notificationService.requestNotificationPermission();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationService.firebaseInit(navigatorKey.currentContext!);
      notificationService.setupInteractMessage(navigatorKey.currentContext!);
    });

    subscribe();
  }

  // Update locale dynamically and persist it
  void changeLanguage(Locale locale) async {
    Get.updateLocale(locale);
    await LanguageHelper.saveLanguage(locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     // locale: widget.initialLocale,
      title: TTexts.appName,
      navigatorKey: navigatorKey, // Assign global navigator key
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // localizationsDelegates: const [
      //   AppLocalizationDelegate(), // Custom localization delegate
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en', ''), // English
      //   Locale('de', ''), // German
      // ],
    );
  }
}

Future<void> _initializeGuestToken() async {
  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('guest_token')) {
    String guestToken = _generateToken();
    await prefs.setString('guest_token', guestToken);
  }
}

String _generateToken() {
  String random = Random().nextInt(1000000).toString();
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  return '${random}_$timestamp';
}

// Function to subscribe to a global FCM topic
void subscribe() {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.subscribeToTopic('global');
}
