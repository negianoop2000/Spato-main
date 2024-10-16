import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';

class DetailOrder_S_View extends StatelessWidget {
  final Map<String, dynamic> orderDetails;

  DetailOrder_S_View({required this.orderDetails});

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
    Color background2 = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    Color textColor = Theme.of(context).brightness == Brightness.light
        ? TColors.black
        : TColors.white;


    List<dynamic>? assignmentDetails = orderDetails['assignmentDtl'];

    return Scaffold(
      appBar: AppBar(
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
            if (assignmentDetails != null && assignmentDetails.isNotEmpty)
              buildCommonDetails(assignmentDetails.first,context),
            SizedBox(height: 16.0),
            // Product List
            if (assignmentDetails != null)
              ...assignmentDetails.map((item) => buildProductDetail(item,context)).toList(),
          ],
        ),
      ),
    );
  }

  Widget buildCommonDetails(Map<String, dynamic> orderDetails,context) {
    final theme = Theme.of(context);
    Color background = theme.brightness == Brightness.light
        ? TColors.containerFill
        : TColors.black;
    Color borderColor = theme.brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor),
        ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDetailRow('Order Number', orderDetails['Auftrags_Nr']),
            buildDetailRow('Offer Number', orderDetails['Angebots_Nr']),
            buildDetailRow('Order Date', orderDetails['Auftragsdatum']),
            buildDetailRow('Reference', orderDetails['Referenz']),
            buildDetailRow('Customer Number', "${orderDetails['name']}(${orderDetails['Ihre_Kundennummer']})"),
            buildDetailRow('Total Net', orderDetails['gesamt_netto']),
            buildDetailRow('VAT', orderDetails['zzgl_Umsatzsteuer']),
            buildDetailRow('Total Gross', orderDetails['Gesamtbetrag_brutto']),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: TColors.colorsecondaryLight),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value?.toString() ?? '',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: TColors.colorsecondaryLight),
            ),
          ),
        ],
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            Table(
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
              },
              children: [
                buildTableRow('Product', product['Produkt']),
                buildTableRow('Description', product['Beschreibung']),
                buildTableRow('Crowd', product['Menge']),
                buildTableRow('Unit', product['Einheit']),
                buildTableRow('Unit Price', product['Einzelpreis']),
                buildTableRow('Discount', product['Rabatt']),
                buildTableRow('Total Price', product['Gesamtpreis']),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow buildTableRow(String label, dynamic value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            '$label:',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: TColors.colorsecondaryLight),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            value?.toString() ?? '',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: TColors.colorsecondaryLight),
          ),
        ),
      ],
    );
  }

}
