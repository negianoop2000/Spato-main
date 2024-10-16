// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:math';
// import 'package:get/get.dart';
// //import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:spato_mobile_app/utils/Connectivity.dart';
// import 'package:spato_mobile_app/utils/theme/theme.dart';
// import 'app/routes/app_pages.dart';
// import 'utils/constants/text_strings.dart';
//
//
// // @pragma('vm:entry-point')
// // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// //   if (Platform.isAndroid) {
// //     await Firebase.initializeApp(
// //       options: FirebaseOptions(
// //         apiKey: 'your-api-key',
// //         appId: 'your-app-id',
// //         messagingSenderId: 'your-messaging-sender-id',
// //         projectId: 'your-project-id',
// //       ),
// //     );
// //   } else {
// //     await Firebase.initializeApp();
// //   }
// //   print('Handling a background message ${message.messageId}');
// // }
//
// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }
//
// void main() async {
//   HttpOverrides.global = MyHttpOverrides();
//   WidgetsFlutterBinding.ensureInitialized();
//  // Get.put(ConnectivityService());
//
//   // if (Platform.isAndroid) {
//   //   await Firebase.initializeApp(
//   //     options: FirebaseOptions(
//   //       apiKey: 'your-api-key',
//   //       appId: 'your-app-id',
//   //       messagingSenderId: 'your-messaging-sender-id',
//   //       projectId: 'your-project-id',
//   //     ),
//   //   );
//   // } else {
//   //   await Firebase.initializeApp();
//   // }
//   // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//   await _initializeGuestToken();
//   // Get.put(ConnectivityService());
//   runApp(SpatoApp()
//     // ChangeNotifierProvider(
//     //   create: (context) => NetworkController(),
//     //   child: SpatoApp(),
//     // ),
//   );
// }
//
// class SpatoApp extends StatelessWidget {
//   const SpatoApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: TTexts.appName,
//       themeMode: ThemeMode.system,
//       theme: TAppTheme.lightTheme,
//       darkTheme: TAppTheme.darkTheme,
//       debugShowCheckedModeBanner: false,
//       initialRoute: AppPages.INITIAL,
//       getPages: AppPages.routes,
//     );
//   }
// }
//
// Future<void> _initializeGuestToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   if (!prefs.containsKey('guest_token')) {
//     String guestToken = _generateToken();
//     await prefs.setString('guest_token', guestToken);
//     print('Guest Token saved: $guestToken');
//   } else {
//     String? guestToken = prefs.getString('guest_token');
//     print('Guest Token already exists: $guestToken');
//   }
// }
//
// String _generateToken() {
//   String random = Random().nextInt(1000000).toString();
//   String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
//   return '${random}_$timestamp';
// }
// //class SparePartScreenView extends StatelessWidget {
// //   final SparePartScreenController controller = Get.put(SparePartScreenController());
// //
// //   @override
// //   Widget build(BuildContext context) {
// //
// //     final List<SparePart> spareParts = Get.arguments['spareParts'];
// //
// //     Color colorsecondary = Theme.of(context).brightness == Brightness.light
// //         ? TColors.colorsecondaryLight
// //         : TColors.colorsecondaryDark;
// //     Color colorsecondary1 = Theme.of(context).brightness == Brightness.light
// //         ? Colors.grey.shade600
// //         : Colors.grey.shade400;
// //     Color background = Theme.of(context).brightness == Brightness.light
// //         ? TColors.colorlightgrey.withOpacity(0.1)
// //         : TColors.black;
// //     Color borderColor = Theme.of(context).brightness == Brightness.light
// //         ? TColors.colorlightgrey
// //         : TColors.darkerGrey;
// //
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Spare Parts", style: AppTextStyles.black20.copyWith(fontWeight: FontWeight.w600, color: colorsecondary)),
// //         leading: InkWell(
// //           onTap: () {
// //             Get.back();
// //           },
// //           child: Padding(
// //             padding: const EdgeInsets.only(left: 20),
// //             child: Container(
// //               height: 50,
// //               width: 50,
// //               decoration: BoxDecoration(
// //                 shape: BoxShape.circle,
// //                 color: background,
// //                 border: Border.all(
// //                   color: borderColor,
// //                 ),
// //               ),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(12.0),
// //                 child: Icon(Icons.arrow_back_ios, color: colorsecondary, size: 15),
// //               ),
// //             ),
// //           ),
// //         ),
// //         centerTitle: true,
// //       ),
// //       body: Obx(() {
// //         return Stack(
// //           children: [
// //             ListView.builder(
// //               itemCount: spareParts.length,
// //               itemBuilder: (context, index) {
// //                 final sparePart = spareParts[index];
// //                 return Padding(
// //                   padding: const EdgeInsets.all(15.0),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         '${sparePart.articleName}',
// //                         style: AppTextStyles.black16.copyWith(fontWeight: FontWeight.w600, color: colorsecondary)
// //                       ),
// //                       // Row(
// //                       //   children: [
// //                       //     Expanded(
// //                       //       child: Obx(() {
// //                       //         return CachedNetworkImage(
// //                       //           imageUrl: controller.imageUrl.value.isNotEmpty
// //                       //               ? controller.imageUrl.value
// //                       //               : "assets/images/no-item-found.png",
// //                       //           placeholder: (context, url) => Center(
// //                       //             child: Padding(
// //                       //               padding: const EdgeInsets.all(20.0),
// //                       //               child: CircularProgressIndicator(),
// //                       //             ),
// //                       //           ),
// //                       //           errorWidget: (context, url, error) => Center(
// //                       //             child: Image.asset("assets/images/no-item-found.png"),
// //                       //           ),
// //                       //           fit: BoxFit.cover,
// //                       //         );
// //                       //       }),
// //                       //     ),
// //                       //     Expanded(
// //                       //       child: Text(
// //                       //         'Article Name: ${sparePart.articleName}',
// //                       //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                       //       ),
// //                       //     ),
// //                       //   ],
// //                       // ),
// //
// //                       SizedBox(height: 12),
// //                       GestureDetector(
// //                         onTapUp: (details) {
// //                           controller.extractText_sparePart(details.globalPosition ,sparePart.productId.toString());
// //                         },
// //                         // onPanUpdate: (details) {
// //                         //   controller.handleImageClick(details.globalPosition);
// //                         // },
// //                         child: Container(
// //                           width: double.infinity,
// //                           height: MediaQuery.of(context).size.width,
// //                           decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(0),
// //                             border: Border.all(
// //                               color: borderColor,
// //                             )
// //                           ),
// //                           child: InteractiveViewer(
// //                             child: CachedNetworkImage(
// //                               imageUrl: "https://spa2.de/storage/spare_part/images/${sparePart.articleImage}",
// //                               placeholder: (context, url) => Center(
// //                                 child: Padding(
// //                                   padding: const EdgeInsets.all(20.0),
// //                                   child: CircularProgressIndicator(),
// //                                 ),
// //                               ),
// //                               errorWidget: (context, url, error) => Center(
// //                                 child: Image.asset("assets/images/no-item-found.png"),
// //                               ),
// //                               fit: BoxFit.cover,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 );
// //               },
// //             ),
// //             if (controller.isLoading.value)
// //               Center(child: CircularProgressIndicator())
// //           ],
// //         );
// //       }),
// //     );
// //   }
// // }
//
//
// //class SparePartScreenController extends GetxController {
// //   final List<SparePart> spareParts = Get.arguments['spareParts'];
// //   var count = 0.obs;
// //   var isLoading = false.obs;
// //   var imageUrl = "".obs;
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchSparePartImages();
// //   }
// //
// //   Future<void> fetchSparePartImages() async {
// //     try {
// //       isLoading(true);
// //       for (var sparePart in spareParts) {
// //         await getSparepartImage(sparePart.productId.toString());
// //       }
// //     } catch (e) {
// //       print('Error fetching spare part images: $e');
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// //
// //   Future<void> getSparepartImage(String productId) async {
// //     try {
// //       var response = await ApiService().getSparepartImage(productId);
// //       print('SparePart Image API response: $response');
// //       if (response != null && response['sparePartImage'] != null) {
// //         await get_image(response['sparePartImage']['Bild_1']);
// //       }
// //     } catch (e) {
// //       print('Error fetching spare part image: $e');
// //     }
// //   }
// //
// //   Future<void> get_image(String imageBuild) async {
// //     try {
// //       var response = await ApiService().get_Image(imageBuild);
// //       if (response.containsKey('url')) {
// //         imageUrl.value = response['url'];
// //         print('Image URL: ${imageUrl.value}');
// //       }
// //     } catch (e) {
// //       print('Error fetching image data: $e');
// //     }
// //   }
// //
// //
// //   var tableData = <Map<String, dynamic>>[].obs;
// //   var errorMessage = ''.obs;
// //
// //
// //   Future<void> extractText_sparePart(Offset position , String productId) async {
// //     try {
// //       var response = await ApiService().extractText_sparePartApi(position , productId);
// //       print('spare part response : $response');
// //       if (response != null && response['filteredData'] != null) {
// //         final item = response['filteredData'];
// //         tableData.insert(0, {
// //           'part_no': item['part_no'],
// //           'id': item['id'],
// //           'Beschreibung': item['Beschreibung'],
// //           'Artikelnummer': item['Artikelnummer'],
// //           'rate': item['rate'].toStringAsFixed(2),
// //         });
// //       }
// //     } catch (e) {
// //       print('Error fetching spare part image: $e');
// //     }
// //   }
// //
// //
// //   @override
// //   void onClose() {
// //     super.onClose();
// //   }
// //
// //   void increment() => count.value++;
// // }


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

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await _initializeGuestToken();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Instantiate NotificationService
  final NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();

    // Initialize FCM service and notification service
    FcmService.firebaseInit();

    notificationService.requestNotificationPermission();

    // Initialize Firebase notifications and handle interactions after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationService.firebaseInit(navigatorKey.currentContext!);
      notificationService.setupInteractMessage(navigatorKey.currentContext!);
    });

    subscribe();  // Subscribe to 'global' topic for notifications
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      navigatorKey: navigatorKey,  // Assign global navigator key
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}

// Utility function to initialize guest token in shared preferences
Future<void> _initializeGuestToken() async {
  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('guest_token')) {
    String guestToken = _generateToken();
    await prefs.setString('guest_token', guestToken);
    print('Guest Token saved: $guestToken');
  } else {
    String? guestToken = prefs.getString('guest_token');
    print('Guest Token already exists: $guestToken');
  }
}

// Helper function to generate a unique guest token
String _generateToken() {
  String random = Random().nextInt(1000000).toString();
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  return '${random}_$timestamp';
}

// Function to subscribe to a global FCM topic
void subscribe() {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.subscribeToTopic('global');
  print("Subscribed to global topic");
}
