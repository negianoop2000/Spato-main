import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spato_mobile_app/app/modules/Offer_Role_screen/controllers/offer_Role_screen_controller.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';



class DetailOfferView extends StatelessWidget {
  final List<Map<String, dynamic>> offersList;

  DetailOfferView({
    required this.offersList,
  });

  @override
  Widget build(BuildContext context) {
    final offer_RoleScreenController controller = Get.put(offer_RoleScreenController());
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

    // Check if the offer is expired based on the first offer's date
    final offerDate = DateFormat("yyyy-MM-dd").parse(offersList.first['Angebotsdatum'] ?? '');
    final currentDate = DateTime.now();

    // Determine if the offer is open or expired
    final isOpen = offerDate.isAfter(currentDate.subtract(Duration(days: 1))) || offerDate.isAtSameMomentAs(currentDate);
    final isClaimed = offersList.first['status'] == 'Confirmed';

    return Scaffold(
      appBar: AppBar(
        title: Text('Your offers are Below', style: TextStyle(color: colorsecondary)),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: colorsecondary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: borderColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          buildDetailRow('Gesamt netto', '${offersList.first['gesamt_netto']}',context),
                          buildDetailRow('zzgl. Umsatzsteuer 19 %', '${offersList.first['zzgl_Umsatzsteuer']}',context),
                          buildDetailRow('Gesamtbetrag brutto', '${offersList.first['Gesamtbetrag_brutto']}',context),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  if(!isOpen)
                    Align( alignment: Alignment.bottomRight,
                      child: Text(
                        'Expired',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.red),
                      ),
                    ),
                  if (isOpen)
                    Align( alignment: Alignment.bottomRight,
                      child:   IntrinsicWidth(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: TColors.colorprimaryLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if(!isClaimed){
                                controller.statusChange(offersList.first['Angebots_Nr'] ?? '', "Open");
                              }
                            },
                            child: isClaimed ? Text("Claimed",style: TextStyle(color: colorsecondary),) : Text("Claim Offer",style: TextStyle(color: colorsecondary),),
                          ),
                        ),
                      ),
                    ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('Product Name', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: colorsecondary))),
                        DataColumn(label: Text('Menge', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: colorsecondary))),
                        DataColumn(label: Text('Einheit', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: colorsecondary))),
                        DataColumn(label: Text('Einzelpreis', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: colorsecondary))),
                        DataColumn(label: Text('Rabatt', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: colorsecondary))),
                        DataColumn(label: Text('Gesamtpreis', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: colorsecondary))),
                      ],
                      rows: offersList.map((offer) {
                        return DataRow(
                          cells: [
                            DataCell(Text(offer['Produkt'] ?? '')),
                            DataCell(Text(offer['Menge'] ?? '')),
                            DataCell(Text(offer['Einheit'] ?? '')),
                            DataCell(Text('${_formatPrice(offer['Einzelpreis'] ?? '0')}€')),
                            DataCell(Text('${offer['Rabatt']}%')),
                            DataCell(Text('${_formatPrice(offer['Gesamtpreis'] ?? '0')}€')),
                          ],
                        );
                      }).toList(),
                    ),
                  ),

                  Divider(color: borderColor),
                  // Text("Scroll toword right ->"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  String _formatPrice(String price) {
    try {
      double? parsedPrice = double.tryParse(price);
      return parsedPrice != null ? parsedPrice.toStringAsFixed(2) : '0.00';
    } catch (e) {
      return '0.00';
    }
  }

  Widget buildDetailRow(String label, dynamic value,BuildContext context) {
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
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: colorsecondary),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value?.toString() ?? '',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: colorsecondary),
            ),
          ),
        ],
      ),
    );
  }
}




