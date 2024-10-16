import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/pdf.dart'; // Import Pdf class
import 'package:pdf/widgets.dart' as pw; // Import widgets with alias pw
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:spato_mobile_app/app/modules/myOrder_screen/controllers/my_order_screen_controller.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import '../../../../common/common_app_buttons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/widgets.dart' as pw;

class DetailOrder_b2c_View extends StatelessWidget {
  final Map<String, dynamic> orderDetails;

  DetailOrder_b2c_View({required this.orderDetails});

  final MyOrderScreenController controller = Get.put(MyOrderScreenController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorsecondary = theme.brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;

    Color background = theme.brightness == Brightness.light
        ? TColors.containerFill
        : TColors.black;
    Color borderColor = theme.brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;

    List<dynamic>? assignmentDetails = orderDetails['ordersDtl'];

    return Scaffold(
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
                color: background,
                border: Border.all(color: borderColor),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                    Icons.arrow_back_ios, color: colorsecondary, size: 15),
              ),
            ),
          ),
        ),
        title: Text(
            'Associated products', style: TextStyle(color: colorsecondary)),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: colorsecondary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Common Order Details
            if (assignmentDetails != null)
              ...assignmentDetails.map((item) =>
                  buildProductDetail(item, context)).toList(),

            CommonAppButton(
              width: double.infinity,
              color: TColors.colorprimaryLight,
              onPressed: ()  {
                 promptForFileNameAndDirectory(context, orderDetails, assignmentDetails!);
              },
              buttonText: "Download Pdf",
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> loadImageFromAssets(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    return data.buffer.asUint8List();
  }

  Future<void> generatePdf(Map<String, dynamic> orderDetails, List<dynamic> products, String fileName, String directoryPath) async {
    final pdf = pw.Document();

    // Load a valid font that supports Unicode
    final fontData = await rootBundle.load("assets/fonts/SF-Pro.ttf");
    final ttf = pw.Font.ttf(fontData);
    final Uint8List imageData = await loadImageFromAssets('assets/images/ic_launcher.png');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        header: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.centerRight,
            padding: const pw.EdgeInsets.only(bottom: 16),
            child: pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Image(pw.MemoryImage(imageData), width: 150),
            ),

          );
        },
        footer: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.center,
            margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.Text("SPATO GmbH \n Schellberger Weg 34 \n 42659 DE - Solingen \nGermany"),
                pw.Text("E-Mail: info@spato.de \n Web: www.spato.de \nDistrict Court Wuppertal\nHR-No.: 32131\nUST.-ID: DE346441844\nTax no.: 128/5820/8408 " ),

                pw.Text("City Savings Bank Solingen  \nAccount: PayPal info@spato.de \nBLZ: 342 500 00 \nIBAN: DE18 3425 0000 0001 8942 11 \nBIC: SOLSDE33XXX"),

              ]
            )
          );
        },

        build: (pw.Context context) => [
          pw.SizedBox(height: 20),
          pw.TableHelper.fromTextArray(
            border: pw.TableBorder.all(),
            headers: ['Product', 'Manufacturer', 'Quantity', 'Unit Price', 'Total Price'],
            data: products.map((product) {
              return [
                product['Artikelname'] ?? 'N/A',
                product['Hersteller'] ?? 'N/A',
                product['product_quanty'] ?? 'N/A',
                product['product_price'] ?? 'N/A',
                product['order_total'] ?? 'N/A'
              ];
            }).toList(),
            headerStyle: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold),
            cellStyle: pw.TextStyle(font: ttf),
            headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(2),
              4: const pw.FlexColumnWidth(2),
            },
          ),
        ],
      ),
    );

    final filePath = "$directoryPath/$fileName.pdf";
    final file = File(filePath);

    // Write the PDF file
    await file.writeAsBytes(await pdf.save());

    // Notify user
    Get.snackbar("Success", "PDF downloaded at: $filePath");
  }

  void promptForFileNameAndDirectory(BuildContext context, Map<String, dynamic> orderDetails, List<dynamic> products) async {
    String? fileName;

    await showDialog(
      context: context,
      builder: (context) {
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
      String? directoryPath = await FilePicker.platform.getDirectoryPath();

      if (directoryPath != null) {
        generatePdf(orderDetails, products, fileName!, directoryPath);
      } else {
        Get.snackbar("Error", "Please select a directory to save the PDF.");
      }
    } else {
      Get.snackbar("Error", "Please enter a valid file name.");
    }
  }

  Widget buildProductDetail(Map<String, dynamic> product, context) {
    final theme = Theme.of(context);
    Color background = theme.brightness == Brightness.light
        ? TColors.containerFill
        : TColors.black;
    Color borderColor = theme.brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;

    final colorsecondary = theme.brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;

    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder<String>(
              future: controller.get_image(product['Bild_1']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 80,
                    width: 80,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: borderColor),
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset("assets/images/no-item-found.png"),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: borderColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        snapshot.data!,
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      ),
                    ),
                  );
                }
              },
            ),
            Table(
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
              },
              children: [
                buildTableRow('Product', product['Artikelname'], colorsecondary),
                buildTableRow('Manufacturer', product['Hersteller'], colorsecondary),
                buildTableRow('Quantity', product['product_quanty'], colorsecondary),
                buildTableRow('Unit Price', product['product_price'], colorsecondary),
                buildTableRow('Total Price', product['order_total'], colorsecondary),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow buildTableRow(String label, dynamic value, Color color) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            '$label:',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            value?.toString() ?? '',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: color),
          ),
        ),
      ],
    );
  }
}
