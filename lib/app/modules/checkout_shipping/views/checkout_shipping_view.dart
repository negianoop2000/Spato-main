import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/common/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';

import '../controllers/checkout_shipping_controller.dart';

class CheckoutShippingView extends StatelessWidget {
  final CheckoutShippingController controller = Get.put(CheckoutShippingController());

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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          TTexts.txtCheckout,
          style: AppTextStyles.black20.copyWith(fontWeight: FontWeight.w600, color: colorsecondary),
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
                border: Border.all(
                  color: borderColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.arrow_back_ios, color: colorsecondary, size: 15),
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
                    return Center(child: Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
                      child:  ShowLoader.isLoadingProgress(controller.isLoading.value),
                    ));
                  } else if (controller.addresses.isEmpty) {
                    return const Center(child: Text('No addresses available.'));
                  } else {
                    return ListView.separated(
                      itemCount: controller.addresses.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final address = controller.addresses[index];
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: borderColor,
                            ),
                          ),
                          child: Obx(() => RadioListTile<int>(
                            title: Text(
                              address,
                              style: AppTextStyles.black14.copyWith(color: colorsecondary),
                            ),
                            value: index,
                            groupValue: controller.selectedAddressId.value,
                            activeColor: TColors.colorlightgrey,
                            onChanged: (int? value) {
                              controller.selectAddress(value);
                            },
                          )),
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonAppButton(
              width: double.infinity,
              color: TColors.colorprimaryLight,
              onPressed: () {
                controller.printAddressesAndSelectedId();
                controller.checkOut(context);
              },
              buttonText: "Continue",
            ),
            const SizedBox(height: 12),
            CommonAppButton(
              width: double.infinity,
              color: Theme.of(context).brightness == Brightness.light
                  ? TColors.colorlightgrey.withOpacity(.10)
                  : Colors.grey.shade700,
              onPressed: () {
                Get.toNamed(Routes.CHECKOUT_INFORMATION, arguments: {'callback': controller.addressListFetched});
              },
              buttonText: "Add New Address",
              btnTextStyle: TextStyle(color: colorsecondary),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

}








