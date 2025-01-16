import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/common/bottomNavigationTap.dart';
import 'package:spato_mobile_app/common/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';

import '../../../../utils/constants/image_strings.dart';
import '../controllers/checkout_congratulation_controller.dart';
class CheckoutCongratulationView extends GetView<CheckoutCongratulationController> {
  const CheckoutCongratulationView({Key? key}) : super(key: key);

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
          style: AppTextStyles.black20.copyWith(
            fontWeight: FontWeight.w600,
            color: colorsecondary,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
                () => controller.isLoading.value
                ? Center(
              child:  Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
                child:  ShowLoader.isLoadingProgress(controller.isLoading.value),
              ),
            )
                : Column(
              children: [
                SvgPicture.asset(TImages.imgCongicon),
                Text(
                  TTexts.txtCongratulations,
                  style: AppTextStyles.textHeadingTitle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: TColors.colorprimaryLight,
                  ),
                ),
                Text(
                  TTexts.txtYourorder,
                  style: AppTextStyles.textTitleMedium.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: TColors.colorlightgrey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummaryItem(
                      title: "Subtotal",
                      value: "€${controller.subtotal.value.toStringAsFixed(2)}",
                    ),
                    _buildSummaryItem(
                      title: "Tax",
                      value: "€${controller.tax.value.toStringAsFixed(2)}",
                    ),
                    _buildSummaryItem(
                      title: "Order Total",
                      value: "€${controller.orderTotal.value.toStringAsFixed(2)}",
                      isTotal: true,
                    ),
                    if(controller.isCouponApplied.value)
                    _buildSummaryItem(
                      title: "Discounted Total",
                      value: "€${controller.discount.value.toStringAsFixed(2)}",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonAppButton(
              width: double.infinity,
              color: TColors.colorlightgrey,
              onPressed: () async {
                await controller.clearPreferences();
                Get.offNamed(Routes.MY_ORDER_SCREEN);
              },
              buttonText: TTexts.txtOrderDetails,
            ),
            SizedBox(height: 12),
            Obx(
                  () => Text(
                "Order ${controller.OrderId.value}",
                style: AppTextStyles.grey16.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorsecondary,
                ),
              ),
            ),
            SizedBox(height: 12),
            CommonAppButton(
              width: double.infinity,
              color: TColors.colorprimaryLight,
              onPressed: () async {
                await controller.clearPreferences();
                Get.offAll(() => BottomNavigationTap());
              },
              buttonText: TTexts.txtContinueShopping,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem({required String title, required String value, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.grey12.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.black14.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: isTotal ? TColors.grey : TColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}


