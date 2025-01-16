import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../common/bottomNavigationTap.dart';
import '../../../../common/custom_appbar.dart';
import '../../../../utils/constants/api_service.dart';
import '../../../../utils/constants/app_text_styles.dart';
import '../../../../utils/constants/colors.dart';
import '../controllers/b2b_shop_admin.dart';
import '../model_chartdata.dart';



class B2bShopAdmin extends StatelessWidget {

  String userid;

  B2bShopAdmin({super.key, required this.userid});

  List<ChartData> chartData = [
    ChartData(0, 35),
    ChartData(1, 18),
    ChartData(2, 24),
    ChartData(3, 32),
    ChartData(4, 40),
    ChartData(5, 50),
    ChartData(6, 55),
  ];

  @override
  Widget build(BuildContext context) {
    Color colorSecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.containerFill
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    Get.delete<B2bShopAdminController>();
    final B2bShopAdminController controller = Get.put(B2bShopAdminController(userid: userid), permanent: false);
    Color colortheme = TColors.colorprimaryLight;
    TextEditingController messageController = TextEditingController();
    bool isActive = false;
    return Scaffold(
      appBar:  AppBar(
        leading: InkWell(
          onTap: () {
            Get.offAll(() => BottomNavigationTap(initialIndex: 3));
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
                child: Icon(Icons.arrow_back_ios, color: colorSecondary, size: 15),
              ),
            ),
          ),
        ),
        title:Obx(()=> Text(
            "${controller.shopname.value}'s B2B Shop",
          style: AppTextStyles.black20.copyWith(fontWeight: FontWeight.w600, color: colorSecondary),
        )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('EEEE, MMMM d, y').format(DateTime.now()),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: controller.shopStatus.value == "1" ? Colors.green.shade300 : Colors.red.shade300,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      controller.shopStatus.value == "1" ? "Approved User" : "Not Approved",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Obx(() {
                      String fullText = ApiService.baseUrl + controller.shopId.value;
                      return Text(
                        fullText,
                        style: const TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      );
                    }),
                  ),
                  Tooltip(
                    message: 'Copy to clipboard',
                    child: IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                          text: ApiService.baseUrl + controller.shopId.value,
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Copied to clipboard')),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Obx(() => DropdownButton<String>(
                    value: controller.selectedMonth.value != "Choose Month" ? controller.selectedMonth.value : null,
                    hint: const Text("Choose Month"),
                    onChanged: controller.onMonthChanged,
                    items: controller.monthOptions.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    underline: const SizedBox(),
                  )),
                ),
                Container(
                 padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 48,
                  decoration: BoxDecoration(
                    color: colortheme,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      final selectedDate = controller.selectedMonth.value;
                      final userId = controller.userid;

                      controller.downloadReport(selectedDate, userId, context);
                    },
                    child: Center(
                      child: const Text(
                        "Download Report",
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: colortheme,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: const Text("Warning Message"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: messageController,
                                    maxLines: 5,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Type your message here",
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        String message = messageController.text;
                                        if (message.isEmpty) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Please enter a message before saving."),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        } else {
                                          controller.savePaymentAlertMessage(userid, message);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text("Action Saved and Activated: $message"),
                                            ),
                                          );
                                          setState(() {
                                            isActive = true;
                                          });
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: colortheme,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                          child: Text("Save", style: TextStyle(color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        String message = messageController.text;
                                        if (message.isEmpty) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Please enter a message before toggling."),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        } else {
                                          setState(() {
                                            isActive = !isActive;
                                          });

                                          controller.paymentAlertStatus(userid, isActive ? "Active" : "De-Active");

                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                isActive ? "Activated: $message" : "Deactivated: $message",
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: isActive ? Colors.red.shade300 : Colors.green.shade300,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                          child: Text(
                                            isActive ? "Deactivate" : "Activate",
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: const Text("Make Warning Message", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            Container(
                height: 400,
                padding: const EdgeInsets.all(15),
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  title: const ChartTitle(text: 'Sales Turnover Yearly'),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  primaryXAxis: const NumericAxis(),
                  series: <LineSeries<ChartData, int>>[
                    LineSeries<ChartData, int>(
                      name: "Sales",
                      color: Colors.red,
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      markerSettings: const MarkerSettings(isVisible: true,
                      color: Colors.red),
                    )
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "B2B Shop Subscription",
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Obx(() {

                           controller.textController.text = "${controller.commissionOnSale.value.toStringAsFixed(2)}%";
                            return TextField(
                              controller: controller.textController,
                              onEditingComplete: () {
                                final value = controller.textController.text.replaceAll('%', '').trim();
                                final numericValue = double.tryParse(value);
                                if (numericValue != null) {
                                  controller.commissionOnSale.value = numericValue;
                                }
                                FocusScope.of(context).unfocus();
                              },
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 70,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                final value = controller.textController.text.replaceAll('%', '').trim();
                                final numericValue = double.tryParse(value);
                                if (numericValue != null) {
                                  controller.commissionOnSale.value = numericValue;
                                }
                                FocusScope.of(context).unfocus();

                                controller.updateSubscriptionShopPrice(userid, controller.commissionOnSale.value.toString());
                              },
                              child: Center(
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text("Save", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            GetBuilder<B2bShopAdminController>(
              builder: (controller) => SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: controller.subscriptions.length,
                  itemBuilder: (context, index) {
                    final subscription = controller.subscriptions[index];
                    TextEditingController priceController = TextEditingController(
                      text: subscription['price']?.toString() ?? '',
                    );
                    return ListTile(
                      title: Text(subscription['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  controller: priceController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: '€',
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 70,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      String newPrice = priceController.text;
                                      if (newPrice.isNotEmpty) {
                                        double? parsedPrice = double.tryParse(newPrice);
                                        if (parsedPrice != null) {
                                          controller.updateFeatureCharge(
                                              userid, subscription['name'], parsedPrice.toString(), index);
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text("Invalid price entered")),
                                          );
                                        }
                                      }
                                    },
                                    child: Center(
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8),
                                        child: Text("Save", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 150,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: subscription['subscribed'] ? Colors.red[300] : Colors.green[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: GestureDetector(
                                    onTap: subscription['price'] != null && subscription['price'] > 0
                                        ? () {
                                      final action = (subscription['subscribed'] as bool)
                                          ? "Un-Subscribe"
                                          : "Subscribe";
                                      controller.updateSubscription(userid, subscription['name'], action,
                                          subscription['price'].toString(), index);
                                    }
                                        : null,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                        child: Text(
                                          subscription['subscribed'] ? "Un-Subscribe" : "Subscribe",
                                          style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                          if (subscription['newStatusRequest'] != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                subscription['newStatusRequest'],
                                style: const TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            ],
          ),
        )
    );
  }
}