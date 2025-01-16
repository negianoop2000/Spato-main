// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'get_server_key.dart';
//
// class SendNotificationService {
//   static Future<void> sendNotificationUsingApi({
//     required String? token,
//     required String? title,
//     required String? body,
//     required Map<String, dynamic>? data,
//   }) async {
//     String serverKey = await GetServerKey().getServerKeyToken();
//     print("Notification server key => $serverKey");
//
//     String url =
//         "https://fcm.googleapis.com/v1/projects/notification-for-android-485/messages:send";
//
//     var headers = <String, String>{
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $serverKey',
//     };
//
//     // Flatten and sanitize the data map, convert nested objects to JSON strings
//     Map<String, dynamic> sanitizedData = {};
//     data?.forEach((key, value) {
//       if (key.isNotEmpty) {
//         // Convert non-primitive types to JSON strings
//         if (value is Map || value is List) {
//           sanitizedData[key] = jsonEncode(value);
//         } else {
//           sanitizedData[key] = value.toString();
//         }
//       }
//     });
//
//     // Constructing the message payload
//     Map<String, dynamic> message = {
//       "message": {
//         // Uncomment the next line to send to a specific device by token
//         // "token": token,
//         "notification": {
//           "body": body,
//           "title": title,
//         },
//         "data": sanitizedData, // Use the sanitized data map
//         "topic": "global",     // Using a topic instead of a token
//       },
//     };
//
//     print(jsonEncode(message).toString());
//
//     // Sending the notification via API
//     final http.Response response = await http.post(
//       Uri.parse(url),
//       headers: headers,
//       body: jsonEncode(message),
//     );
//
//     if (response.statusCode == 200) {
//       print("Notification sent successfully!");
//     } else {
//       print("Failed to send notification: ${response.body}");
//     }
//   }
// }
