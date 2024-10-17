
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/app/modules/myOrder_screen/controllers/my_order_screen_controller.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/common_app_buttons.dart';
import '../../../../utils/constants/app_text_styles.dart';





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
                  String pdfUrl = "https://spa2.de/orders/invoice/$orderNumber";
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
      ),
    );
  }



}



