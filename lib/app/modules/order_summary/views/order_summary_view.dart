import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/common_app_buttons.dart';
import '../../../../utils/constants/colors.dart';
import '../../../modules/checkout_shipping/controllers/checkout_shipping_controller.dart';

class OrderSummaryView extends StatelessWidget {
  final List cartitems;

  OrderSummaryView(this.cartitems, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CheckoutShippingController controller = Get.put(CheckoutShippingController());

    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.containerFill
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;

    double totalPrice = 0.0;
    for (var cartItem in cartitems) {
      double itemFinalRate = double.tryParse(cartItem['final_rate'].toString()) ?? 0.0;
      int quantity = int.tryParse(cartItem['quantity'].toString()) ?? 0;
      totalPrice += itemFinalRate * quantity;
    }

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
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.arrow_back_ios, color: colorsecondary, size: 15),
              ),
            ),
          ),
        ),
        title: Text(
          "Order Summary",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: colorsecondary),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartitems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartitems[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummaryItem("Product Name", cartItem['product_name'] ?? '', colorsecondary),
                      _buildSummaryItem("Price (excl. Tax)", "€${cartItem['Preis_zzgl_MwSt'] ?? '0'}", colorsecondary),
                      _buildSummaryItem("Quantity", "${cartItem['quantity'] ?? '0'}", colorsecondary),
                      _buildSummaryItem("Discount %", "${cartItem['discount_percentage'] ?? '0'}%", colorsecondary),
                      _buildSummaryItem("Final Rate", "€${cartItem['final_rate'] ?? '0'}", colorsecondary),
                      Divider(color: Colors.grey),
                    ],
                  );
                },
              ),
            ),
            Divider(color: Colors.black),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Total Price: €${totalPrice.toStringAsFixed(2)}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorsecondary),
              ),
            ),
            CommonAppButton(
              width: double.infinity,
              color: TColors.colorprimaryLight,
              onPressed: () {
                // controller.printAddressesAndSelectedId();
                // controller.checkOut(context);
               controller.addOrderApi();
              },
              buttonText: "Confirm",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(title, style: TextStyle(fontSize: 14, color: color,fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value, style: TextStyle(fontSize: 14, color: color)),
          ),
        ],
      ),
    );
  }
}
