import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spato_mobile_app/app/modules/Offer_Role_screen/controllers/offer_Role_screen_controller.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';



class offer_RoleScreenView extends StatelessWidget {
  final offer_RoleScreenController controller = Get.put(offer_RoleScreenController());

  @override
  Widget build(BuildContext context) {
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.containerFill
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    Color expiredColor = Colors.red;
    Color openColor = colorsecondary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Offers Lists',
          style: AppTextStyles.black20.copyWith(
            fontWeight: FontWeight.w600,
            color: colorsecondary,
          ),
        ),
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
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
                      child: ShowLoader.isLoadingProgress(controller.isLoading.value),
                    );
                  }

                  return ListView.separated(
                    itemCount: controller.orders.length,
                    separatorBuilder: (context, index) => SizedBox(height: 20,),
                    itemBuilder: (context, index) {
                      final order = controller.orders[index];
                      final offerDate = DateFormat("yyyy-MM-dd").parse(order['Angebotsdatum'] ?? '');
                      final currentDate = DateTime.now();
                      final isOpen = offerDate.isAfter(currentDate.subtract(Duration(days: 1))) || offerDate.isAtSameMomentAs(currentDate);
                      final isClaimed = order['status'] == 'Confirmed';

                      return Container(
                        decoration: BoxDecoration(
                          color: background,
                          border: Border.all(color: borderColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Offer Number: ${order['Angebots_Nr'] ?? ''}",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: colorsecondary),
                              ),
                              Text(
                                "Active till: ${order['Angebotsdatum'] ?? ''}",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colorsecondary),
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Text(
                                    "Status: ${isClaimed ? 'Claimed' : isOpen ? 'Open' : 'Expired'}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: isClaimed ? Colors.green : isOpen ? openColor : expiredColor,
                                    ),
                                  ),
                                  Spacer(),
                                  if (isOpen)
                                    IntrinsicWidth(
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: TColors.colorprimaryLight,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            if(!isClaimed){
                                              controller.statusChange(order['Angebots_Nr'] ?? '', "Open");
                                            }
                                            },
                                          child: isClaimed ? Text("Claimed",style: TextStyle(color: colorsecondary),) : Text("Claim Offer",style: TextStyle(color: colorsecondary),),
                                        ),
                                      ),
                                    ),
                              SizedBox(width: 10),
                                  IntrinsicWidth(
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: TColors.colorprimaryLight,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          controller.navigateToDetailView(order['Angebots_Nr'] ?? '');
                                        },
                                        child: Text('View Offer',style: TextStyle(color: colorsecondary),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
