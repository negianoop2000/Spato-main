import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';


class DetailView extends StatelessWidget {
  final Map<String, dynamic> response;
  final Map<String, dynamic> b2cUserDetails;
  final Map<String, dynamic> b2bUserDetails;

  DetailView({
    required this.response,
    required this.b2cUserDetails,
    required this.b2bUserDetails,
  });

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
    String fullImageUrl = ApiService.imageUrl;

    List<dynamic> orderDetails = response['dealList'] ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
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
              child: Center(
                child: Icon(Icons.arrow_back_ios, color: colorsecondary, size: 15),
              ),
            ),
          ),
        ),
        title: Text('Deal Maker Details', style: TextStyle(color: colorsecondary)),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: colorsecondary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildSection(
              context,
              'Deal Maker Details',
              [
                if (orderDetails.isNotEmpty) buildDetailRow(context, 'Deal Maker Number', orderDetails[0]['Deal_Nr']),
                if (orderDetails.isNotEmpty) buildDetailRow(context, 'Offer Number', orderDetails[0]['Angebots_Nr']),
                if (orderDetails.isNotEmpty) buildDetailRow(context, 'Deal Date', orderDetails[0]['Dealdatum']),
                if (orderDetails.isNotEmpty) buildDetailRow(context, 'Reference', orderDetails[0]['Referenz']),
              ],
              background,
              borderColor,
            ),
            SizedBox(height: 20),
            buildSection(
              context,
              'B2C Customer Details',
              [
                buildDetailRow(context, 'Name', b2cUserDetails['name']),
                buildDetailRow(context, 'Customer Number', b2cUserDetails['id']),
                buildDetailRow(context, 'Contact', b2cUserDetails['mobile']),
                buildDetailRow(context, 'Email', b2cUserDetails['email']),
                buildDetailRow(context, 'Address', b2cUserDetails['address']),
                buildDetailRow(context, 'City', b2cUserDetails['city']),
                buildDetailRow(context, 'Zip code', b2cUserDetails['zipCode']),
                buildDetailRow(context, 'Country', b2cUserDetails['country']),
              ],
              background,
              borderColor,
            ),
            SizedBox(height: 20),
            buildSection(
              context,
              'B2B Customer Details',
              [
                buildDetailRow(context, 'Company', b2bUserDetails['company_name']),
                buildDetailRow(context, 'Customer Number', b2bUserDetails['id']),
                buildDetailRow(context, 'Name', b2bUserDetails['name']),
                buildDetailRow(context, 'Contact', b2bUserDetails['mobile']),
                buildDetailRow(context, 'Email', b2bUserDetails['email']),
                buildDetailRow(context, 'Address', b2bUserDetails['address']),
                buildDetailRow(context, 'City', b2bUserDetails['city']),
                buildDetailRow(context, 'Zip code', b2bUserDetails['zipCode']),
                buildDetailRow(context, 'Country', b2bUserDetails['country']),
                buildDetailRow(context, 'Vat ID', b2bUserDetails['vatNo']),
              ],
              background,
              borderColor,
            ),
            SizedBox(height: 20),
            buildSection(
              context,
              'Product Details',
              orderDetails.map<Widget>((product) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 100,
                      width: 80,
                      child: CachedNetworkImage(
                        imageUrl: "$fullImageUrl${product['Produktimage']}",
                        placeholder: (context, url) => Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Image.asset("assets/images/no-item-found.png"),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  buildDetailRow(context, 'Product', product['Produkt']),
                  buildDetailRow(context, 'Quantity', product['Menge']),
                  buildDetailRow(context, 'Unit Price', product['Einzelpreis']),
                  buildDetailRow(context, 'Total Price', product['Gesamtpreis']),
                  SizedBox(height: 10),
                ],
              )).toList(),
              background,
              borderColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSection(
      BuildContext context,
      String title,
      List<Widget> children,
      Color background,
      Color borderColor,
      ) {
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
            buildSectionHeader(context, title),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget buildSectionHeader(BuildContext context, String title) {
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: colorsecondary),
      ),
    );
  }

  Widget buildDetailRow(BuildContext context, String label, dynamic value) {
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: colorsecondary),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value?.toString() ?? '',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colorsecondary),
            ),
          ),
        ],
      ),
    );
  }
}


