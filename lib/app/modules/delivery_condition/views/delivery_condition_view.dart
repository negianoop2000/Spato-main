import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spato_mobile_app/app/modules/delivery_condition/controllers/delivery_condition_controller.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/common/setting_widget.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';



class DeliveryConditionView extends GetView<DeliveryConditionController> {
  const DeliveryConditionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.containerFillDark
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    Color textColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colordarkgrey
        : TColors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Delivery Condition",
          style: AppTextStyles.black20
              .copyWith(fontWeight: FontWeight.w600, color: colorsecondary),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: background,
                border: Border.all(
                  color: borderColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: colorsecondary,
                  size: 15,
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "General Delivery Conditions of SPATO GmbH\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text: "Delivery within Germany (mainland)\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text: "Parcel goods (per package up to 30 kg)\n"
                        " - up to 350.00 EURO per package: 22.50 €\n"
                        " - Surcharge for guaranteed delivery on the next day: 12.00 EURO\n"
                        " - For goods that cannot be sorted (rolls, 2-meter pipes, etc.): 22.50 EURO each\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "Pallet goods for pipe bundles (per pallet up to 200 kg)\n"
                        " - Maximum 2,000 kg total shipment weight\n"
                        " - up to 1,500 EURO flat rate: 210.00 EURO\n"
                        " - Long goods surcharge (> 2.40 mtr.): 60.00 EURO\n"
                        " - Half pallet up to 100 kg from 900.00 EURO: freight free\n"
                        " - Half pallet up to 100 kg up to 900.00 EURO: flat rate 65.00 EURO\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "Dangerous goods (e.g., water care):\n"
                        " - From 2,200 EUR: free to the door\n"
                        " - up to 2,200 EUR: by shipping company, hazardous goods surcharge 20.00 EURO\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "Freight-intensive goods\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text: "Such as: PVC pipes (long pallets), aluminum rods (from 2.4 m), rolls, containers, filter sand, glass, etc. "
                        "Prices are billed according to the costs/daily prices of the shipping companies.\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "Pallet goods and freight-intensive goods such as heat pumps, filter medium, etc.\n"
                        " - Up to 200 kg: €135.00 per pallet\n"
                        " - Filter medium: on request\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "Express surcharge for freight forwarded goods:\n"
                        " - Guarantee the next day until 4 p.m. throughout Germany (excluding islands): 25.00 EURO\n"
                        " - Guarantee the next day until 12 p.m. nationwide (excluding islands): 40.00 EURO\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "Express deliveries\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text: "According to expenditure. For express orders, the shipping costs are generally borne by the recipient. "
                        "Excluding spare parts and subsequent delivery.\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "Prices\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text: "Per piece or meter in EURO plus VAT, subject to change. "
                        "If there are price increases after completion of this catalog, e.g., in the area of ​​raw materials, "
                        "we reserve the right to adjust the price.\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "Returns of goods\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text: "Returns of goods will only be accepted after prior agreement with our employees. "
                        "The return of goods must be accompanied by a copy of the invoice, not older than 6 weeks. "
                        "The goods must be in perfect condition. The return shipment must be made “free of charge”. "
                        "A restocking fee of at least 15% of the value of the goods will be charged.\n\n"
                        "Custom-made products, special orders, clearance goods, sections (hose, pipe) as well as already installed and dirty product goods and materials are excluded from return.\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "Damage during transport must be recorded in writing on the receipt in the presence of the deliverer. "
                        "Unfortunately, we cannot accept later complaints.\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "Subject to technical changes and printing errors.\n\n",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}