import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/app/modules/myOrder_screen/controllers/my_order_screen_controller.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';

import '../../../../common/common_app_buttons.dart';
import '../../../../utils/constants/app_text_styles.dart';

// class SparepartDetail extends StatelessWidget {
//   final Map<String, dynamic> orderDetails;
//   String? orderNumber;
//
//   SparepartDetail({required this.orderDetails, this.orderNumber});
//
//   final MyOrderScreenController controller = Get.put(MyOrderScreenController());
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorSecondary = theme.brightness == Brightness.light
//         ? TColors.colorsecondaryLight
//         : TColors.colorsecondaryDark;
//
//     Color background = theme.brightness == Brightness.light
//         ? TColors.containerFill
//         : TColors.black;
//     Color borderColor = theme.brightness == Brightness.light
//         ? TColors.colorlightgrey
//         : TColors.darkerGrey;
//
//     List<dynamic>? assignmentDetails = orderDetails['ordersDtl'];
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: InkWell(
//           onTap: () {
//             Get.back(result: true);
//           },
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: Container(
//               height: 50,
//               width: 50,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: background,
//                 border: Border.all(color: borderColor),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Icon(Icons.arrow_back_ios, color: colorSecondary, size: 15),
//               ),
//             ),
//           ),
//         ),
//         title: Text('$orderNumber Detail', style: TextStyle(color: colorSecondary)),
//         centerTitle: true,
//         backgroundColor: theme.scaffoldBackgroundColor,
//         iconTheme: IconThemeData(color: colorSecondary),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.separated(
//           separatorBuilder: (context, index) => SizedBox(height: 20),
//           itemCount: assignmentDetails?.length ?? 0, // Safely handle null
//           itemBuilder: (context, index) {
//             var order = assignmentDetails![index]; // Use null assertion safely here
//             return Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: background,
//                 borderRadius: BorderRadius.circular(15),
//                 border: Border.all(
//                   color: TColors.colorlightgrey,
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Table(
//                   border: TableBorder.all(color: TColors.colorlightgrey),
//                   children: [
//                     // Header Row
//                     TableRow(
//                       decoration: BoxDecoration(
//                         color: TColors.black,
//                       ),
//                       children: [
//                         buildHeaderCell('Detail', colorSecondary),
//                         buildHeaderCell('Value', colorSecondary),
//                       ],
//                     ),
//                     // Data Rows
//                     TableRow(
//                       children: [
//                         buildTableCell('Customer Name', colorSecondary),
//                         buildTableCell(order['POS'].toString() ?? "", colorSecondary),
//                       ],
//                     ),
//                     TableRow(
//                       children: [
//                         buildTableCell('Product', colorSecondary),
//                         buildTableCell(order['Produkt'] ?? "", colorSecondary),
//                       ],
//                     ),
//                     TableRow(
//                       children: [
//                         buildTableCell('Order Number', colorSecondary),
//                         buildTableCell(order['Beschreibung'] ?? "", colorSecondary),
//                       ],
//                     ),
//                     TableRow(
//                       children: [
//                         buildTableCell('Price', colorSecondary),
//                         buildTableCell(order['rate']?.toString() ?? "", colorSecondary),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget buildHeaderCell(String value, Color color) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         value,
//         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
//
//   Widget buildTableCell(String value, Color color) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         value,
//         style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: color),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }


// class SparepartDetail extends StatelessWidget {
//   final Map<String, dynamic> orderDetails;
//   String? orderNumber;
//
//   SparepartDetail({required this.orderDetails, this.orderNumber});
//
//   final MyOrderScreenController controller = Get.put(MyOrderScreenController());
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorSecondary = theme.brightness == Brightness.light
//         ? TColors.colorsecondaryLight
//         : TColors.colorsecondaryDark;
//
//     Color background = theme.brightness == Brightness.light
//         ? TColors.containerFill
//         : TColors.black;
//     Color borderColor = theme.brightness == Brightness.light
//         ? TColors.colorlightgrey
//         : TColors.darkerGrey;
//
//     List<dynamic>? assignmentDetails = orderDetails['ordersDtl'];
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: InkWell(
//           onTap: () {
//             Get.back(result: true);
//           },
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: Container(
//               height: 50,
//               width: 50,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: background,
//                 border: Border.all(color: borderColor),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Icon(Icons.arrow_back_ios, color: colorSecondary, size: 15),
//               ),
//             ),
//           ),
//         ),
//         title: Text('$orderNumber Detail', style: TextStyle(color: colorSecondary)),
//         centerTitle: true,
//         backgroundColor: theme.scaffoldBackgroundColor,
//         iconTheme: IconThemeData(color: colorSecondary),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.separated(
//           separatorBuilder: (context, index) => SizedBox(height: 20),
//           itemCount: assignmentDetails?.length ?? 0, // Safely handle null
//           itemBuilder: (context, index) {
//             var order = assignmentDetails![index]; // Use null assertion safely here
//             return Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: background,
//                 borderRadius: BorderRadius.circular(15),
//                 border: Border.all(
//                   color: TColors.colorlightgrey,
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Table(
//                   border: TableBorder.all(color: TColors.colorlightgrey),
//                   children: [
//                     TableRow(
//                       children: [
//                         buildTableCell('Customer Name', colorSecondary),
//                         buildTableCell(order['POS'].toString() ?? "", colorSecondary),
//                       ],
//                     ),
//                     TableRow(
//                       children: [
//                         buildTableCell('Product', colorSecondary),
//                         buildTableCell(order['Produkt'] ?? "", colorSecondary),
//                       ],
//                     ),
//                     TableRow(
//                       children: [
//                         buildTableCell('Order Number', colorSecondary),
//                         buildTableCell(order['Beschreibung'] ?? "", colorSecondary),
//                       ],
//                     ),
//                     TableRow(
//                       children: [
//                         buildTableCell('Price', colorSecondary),
//                         buildTableCell(order['rate']?.toString() ?? "", colorSecondary),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget buildTableCell(String value, Color color) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         value,
//         style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: color),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SparepartDetail extends StatelessWidget {
  final Map<String, dynamic> orderDetails;
  String? orderNumber;

  SparepartDetail({required this.orderDetails, this.orderNumber});

  final MyOrderScreenController controller = Get.put(MyOrderScreenController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorSecondary = theme.brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;

    List<dynamic>? assignmentDetails = orderDetails['ordersDtl'];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back(result: true);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.scaffoldBackgroundColor,
                border: Border.all(color: TColors.colorlightgrey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.arrow_back_ios, color: colorSecondary, size: 15),
              ),
            ),
          ),
        ),
        title: Text('$orderNumber', style: TextStyle(color: colorSecondary)),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: colorSecondary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height- 170,
                child: ListView.separated(
                  itemCount: assignmentDetails?.length ?? 0,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                    height: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    var order = assignmentDetails![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      child: Container(
                        height: 45,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order['POS'].toString(),
                                    style: AppTextStyles.black14.copyWith(color: colorSecondary),
                                  ),
                                  Text(
                                    "Price - ${order['rate']?.toString() ?? " "}€",
                                    style: AppTextStyles.black14.copyWith(color: colorSecondary),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                order['Produkt'] ?? "",
                                style: AppTextStyles.black14.copyWith(color: colorSecondary),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                order['Beschreibung'] ?? "",
                                style: AppTextStyles.black14.copyWith(color: colorSecondary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              CommonAppButton(
                width: double.infinity,
                color: TColors.colorprimaryLight,
                onPressed: () async {
                 // await _generatePdf(assignmentDetails);
                  promptForFileNameAndDirectory(context, assignmentDetails!);
          
                },
                buttonText: "Download Pdf",
              ),
          
            ],
          ),
        ),
      ),
    );
  }

  void promptForFileNameAndDirectory(BuildContext context, List<dynamic> products) async {
    String? fileName;

    await showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Enter File Name'),
        content: TextField(
          onChanged: (value) {
            fileName = value;
          },
          decoration: InputDecoration(hintText: "File Name"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (fileName != null && fileName!.isNotEmpty) {
                Navigator.of(context).pop();
              }
            },
            child: Text('Submit'),
          ),
        ],
      );
    },
    );

    if (fileName != null && fileName!.isNotEmpty) {
      // Ask the user to select a directory
      String? directoryPath = await FilePicker.platform.getDirectoryPath();

      if (directoryPath != null) {
        // Generate the PDF with the user-specified file name and directory
        _generatePdf(products, fileName!, directoryPath);
      } else {
        Get.snackbar("Error", "Please select a directory to save the PDF.");
      }
    } else {
      Get.snackbar("Error", "Please enter a valid file name.");
    }
  }


  Future<void> _generatePdf(List<dynamic>? assignmentDetails, String filename,String directorypath) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Order Details', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 16),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text('POS', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Product', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Description', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Price', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                  ...assignmentDetails!.map((order) {
                    return pw.TableRow(
                      children: [
                        pw.Text(order['POS'].toString()),
                        pw.Text(order['Produkt'] ?? ""),
                        pw.Text(order['Beschreibung'] ?? ""),
                        pw.Text(order['rate']?.toString() ?? ""),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ],
          );
        },
      ),
    );

    // Get the Downloads directory
    final filePath = "$directorypath/$filename.pdf";
    final file = File(filePath);

    // Write the PDF file
    await file.writeAsBytes(await pdf.save());

      // Notify the user about the file path
      Get.snackbar("Success", "PDF saved in Downloads at $filePath");
  }
}


