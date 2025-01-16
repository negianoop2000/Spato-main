import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spato_mobile_app/common/custom_appbar.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../common/bottomNavigationTap.dart';
import '../../../../utils/constants/app_text_styles.dart';
import '../../../../utils/constants/colors.dart';
import '../controllers/b2b_shop.dart';
import '../model_chartdata.dart';

class B2bShopView extends StatelessWidget {
   B2bShopView({super.key});

  final B2BShopController controller = Get.put(B2BShopController(), permanent: true);

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
    Color colortheme = TColors.colorprimaryLight;
    return Scaffold(
      appBar:const CustomAppBar(title: "B2B Shop"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('EEEE, MMMM d, y').format(DateTime.now()),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Obx(() => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: controller.approvalStatus.value == "1" ? Colors.green.shade300 : Colors.red.shade300,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        controller.approvalStatus.value == "1" ? "Approved User" : "Not Approved",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              Obx(() => controller.showPaymentMessage.value
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          controller.paymentMessage.value,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: () {
                          controller.showPaymentMessage.value = false;
                        },
                      ),
                    ],
                  ),
                ),
              )
                  : const SizedBox.shrink()),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Obx(() {
                        // Safely concatenate and truncate long texts
                        String fullText = ApiService.baseUrl + controller.shopId.value;
                        return Text(
                          fullText,
                          style: const TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                          maxLines: 1,                     // Restrict to a single line
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

                        controller.downloadReport(selectedDate, userId.value, context);
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
                      markerSettings: const MarkerSettings(isVisible: true),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Minimum Shop Charges",
                      style: TextStyle(fontSize: 16),
                    ),
                    Obx(() => Text(
                      "€${controller.minimumShopCharges.value.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 16),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "B2B Shop Subscription",
                      style: TextStyle(fontSize: 16),
                    ),
                    Obx(() => Text(
                      "${controller.commissionOnSale.value.toStringAsFixed(2)}%",
                      style: const TextStyle(fontSize: 16),
                    )),
                  ],
                ),
              ),
              GetBuilder<B2BShopController>(
                builder: (controller) => SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: controller.subscriptions.length,
                    itemBuilder: (context, index) {
                      final subscription = controller.subscriptions[index];
                      return ListTile(
                        title: Text(subscription['name'].toString()),
                        subtitle: subscription['price'] != null
                            ? Text('€${subscription['price']}')
                            : const Text('Price: Not specified'),
                        trailing: SizedBox(
                          width: 150,
                          child: Container(
                            decoration: BoxDecoration(
                              color: (subscription['subscribed'] as bool)
                                  ? Colors.red[300]
                                  : Colors.green[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                final action = (subscription['subscribed'] as bool) ? "Un-Subscribe" : "Subscribe";
                                controller.updateSubscription(
                                  controller.userid.value,
                                  subscription['name'].toString(),
                                  action,
                                  subscription['price'].toString(),
                                );
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),                              child: Text(
                                    (subscription['subscribed'] as bool) ? "Un-Subscribe" : "Subscribe",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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

