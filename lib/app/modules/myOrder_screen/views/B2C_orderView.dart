import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/app/modules/myOrder_screen/controllers/my_order_screen_controller.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../common/common_app_buttons.dart';


class DetailOrder_b2c_View extends StatelessWidget {
  final Map<String, dynamic> orderDetails;
  String ordernumber;

  DetailOrder_b2c_View({required this.orderDetails, required this.ordernumber});

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

    List<dynamic> assignmentDetails = orderDetails['ordersDtl'];

    double totalPrice = assignmentDetails.fold<double>(
      0.0,
          (sum, item) {
        double quantity = double.tryParse(item['product_quanty']?.toString() ?? '0') ?? 0.0;
        double unitPrice = double.tryParse(item['product_price']?.toString() ?? '0.0') ?? 0.0;
        return sum + (quantity * unitPrice);
      },
    );


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
                child: Icon(Icons.arrow_back_ios, color: colorsecondary, size: 15),
              ),
            ),
          ),
        ),
        title: Text('Associated products', style: TextStyle(color: colorsecondary)),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: colorsecondary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Common Order Details
            ...assignmentDetails.map((item) => buildProductDetail(item, context)),

            // Total Price Display
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Total Price: €${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorsecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Download PDF Button
            CommonAppButton(
              width: double.infinity,
              color: TColors.colorprimaryLight,
              onPressed: () async {
                String pdfUrl = "${ApiService.baseUrl}OffersPdfdownload/$ordernumber";
                final Uri url = Uri.parse(pdfUrl);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $pdfUrl';
                }
              },
              buttonText: "Download Pdf",
            ),
          ],
        ),
      ),
    );
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

    double quantity = double.tryParse(product['product_quanty']?.toString() ?? '0') ?? 0.0;
    double unitPrice = double.tryParse(product['product_price']?.toString() ?? '0.0') ?? 0.0;
    double totalPrice = quantity * unitPrice;

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
            FutureBuilder<String?>(
              future: product['Bild_1'] != null
                  ? controller.get_image(product['Bild_1'])
                  : Future.value(null),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 80,
                    width: 80,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError || snapshot.data == null) {
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
                buildTableRow('Product', product['Artikelname'] ?? 'N/A', colorsecondary),
                buildTableRow('Manufacturer', product['Hersteller'] ?? 'N/A', colorsecondary),
                buildTableRow('Quantity', product['product_quanty']?.toString() ?? '0', colorsecondary),
                buildTableRow('Unit Price',"€${product['product_price']!}" ?? '0.0', colorsecondary),
               // buildTableRow('Total Price', product['order_total']?.toString() ?? '0.0', colorsecondary),
                buildTableRow('Total Price', '€${totalPrice.toStringAsFixed(2)}', colorsecondary),


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
            value?.toString() ?? 'N/A', // Provide a default value for null
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
