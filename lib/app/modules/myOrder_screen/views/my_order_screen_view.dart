import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/common/bottomNavigationTap.dart';
import 'package:spato_mobile_app/common/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';

import '../../../../utils/constants/text_strings.dart';
import '../controllers/my_order_screen_controller.dart';

class MyOrderScreenView extends StatelessWidget {

  final MyOrderScreenController controller = Get.put(MyOrderScreenController());

  @override
  Widget build(BuildContext context) {
    Color colorsecondary = Theme
        .of(context)
        .brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme
        .of(context)
        .brightness == Brightness.light
        ? TColors.containerFill
        : TColors.black;
    Color background2 = Theme
        .of(context)
        .brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    Color borderColor = Theme
        .of(context)
        .brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;

    return Scaffold(
      appBar: AppBar(
        title: Text(TTexts.txtMyOrder, style: AppTextStyles.black20.copyWith(
            fontWeight: FontWeight.w600, color: colorsecondary)),
        leading: InkWell(
          onTap: () {
            Get.offAll(() => BottomNavigationTap(initialIndex: 3,));
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
                    color: borderColor, // Replace AppColors.CommanGrey
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.arrow_back_ios, color: colorsecondary, size: 15,),
                )
            ),
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: controller.tabController,
          labelStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
          tabs: [
            Tab(text: "Product Order History"),
            Tab(text: "Spare Part Order History"),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          productOrderHistory(context),
          sparePArtOrderHistory(context),
        ],
      ),
    );
  }

  Widget productOrderHistory(BuildContext context){
    Color colorsecondary = Theme
        .of(context)
        .brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme
        .of(context)
        .brightness == Brightness.light
        ? TColors.containerFill
        : TColors.black;
    Color background2 = Theme
        .of(context)
        .brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    Color borderColor = Theme
        .of(context)
        .brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;

    return Obx(() {
      if (controller.isLoading.value) {
        return Padding(
          padding: EdgeInsets.only(top: MediaQuery
              .of(context)
              .size
              .height * 0.0),
          child: ShowLoader.isLoadingProgress(controller.isLoading.value),
        );
      } else if (controller.orders.isEmpty) {
        return Center(
          child: Text("No Product order found."),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 20,),
            itemCount: controller.orders.length,
            itemBuilder: (context, index) {
              var order = controller.orders[index];
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: TColors.colorlightgrey,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Order Detail",
                                style: AppTextStyles.black16.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: colorsecondary)),
                            Spacer(),
                            CommonAppButton(
                              width: 100,
                              height: 30,
                              color: background2,
                              btnTextStyle: AppTextStyles.black14.copyWith(
                                  color: colorsecondary),
                              borderColor: borderColor,
                              onPressed: () {
                                print("dfgsdfgh ${order['Angebots_Nr'] ?? ''}");
                                controller.navigateToDetailView( order['Angebots_Nr'] ?? '');
                              },
                              buttonText: order['status'] ?? "",
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        buildDetailRow(
                            'Customer Name', order['name'] ?? "",colorsecondary),
                        buildDetailRow(
                            'Order Number', order['Angebots_Nr'] ?? "",colorsecondary),
                        buildDetailRow('Delivery Address',
                            order['delv_address'] ?? "",colorsecondary),
                        buildDetailRow('Delivery estimate',
                            order['Angebotsdatum'] ?? "",colorsecondary),
                        buildDetailRow('Deliver status',
                            order['deliver_status'] ?? "",colorsecondary),


                      ]
                  ),
                ),
              );
            },
          ),
        );
      }
    });
  }

  Widget sparePArtOrderHistory(BuildContext context){
    Color colorsecondary = Theme
        .of(context)
        .brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme
        .of(context)
        .brightness == Brightness.light
        ? TColors.containerFill
        : TColors.black;
    Color background2 = Theme
        .of(context)
        .brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    Color borderColor = Theme
        .of(context)
        .brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;

    return Obx(() {
      if (controller.isLoading.value) {
        return Padding(
          padding: EdgeInsets.only(top: MediaQuery
              .of(context)
              .size
              .height * 0.0),
          child: ShowLoader.isLoadingProgress(controller.isLoading.value),
        );
      } else if (controller.sparePartOrders.isEmpty) {
        return Center(
          child: Text(""),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 20,),
            itemCount: controller.sparePartOrders.length,
            itemBuilder: (context, index) {
              var order = controller.sparePartOrders[index];
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: TColors.colorlightgrey,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Order Detail",
                                style: AppTextStyles.black16.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: colorsecondary)),
                            Spacer(),
                            CommonAppButton(
                              width: 100,
                              height: 30,
                              color: background2,
                              btnTextStyle: AppTextStyles.black14.copyWith(
                                  color: colorsecondary),
                              borderColor: borderColor,
                              onPressed: () {
                                controller.navigateToSparePartDetailView( order['Angebots_Nr'] ?? '',order['Angebots_Nr'] ?? "",);
                              },
                              buttonText:  "Open",
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        buildDetailRow(
                            'Customer Name', order['name'] ?? "",colorsecondary),
                        buildDetailRow(
                            'Order Number', order['Angebots_Nr'] ?? "",colorsecondary),
                        buildDetailRow('Deliver status',
                            order['deliver_status'] ?? "",colorsecondary),

                      ]
                  ),
                ),
              );
            },
          ),
        );
      }
    });
  }

  Widget buildDetailRow(String label, dynamic value,Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: TextStyle(fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value?.toString() ?? '',
              style: TextStyle(fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: color),
            ),
          ),
        ],
      ),
    );
  }
}
