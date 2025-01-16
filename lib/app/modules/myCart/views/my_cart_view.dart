import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/Custom%20Widget/slider_action/src/action_pane_motions.dart';
import 'package:spato_mobile_app/Custom%20Widget/slider_action/src/actions.dart';
import 'package:spato_mobile_app/Custom%20Widget/slider_action/src/slidable.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/common/delete_dialog.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';

import '../controllers/my_cart_controller.dart';


class MyCartView extends StatelessWidget {
  const MyCartView({super.key});

@override
  Widget build(BuildContext context) {
    final MyCartController controller = Get.find<MyCartController>(tag: 'cart');
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.containerFill
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    Color iconselected = Theme.of(context).brightness == Brightness.light
        ? TColors.colorprimaryLight
        : TColors.white;
    Color iconUnselected = Theme.of(context).brightness == Brightness.light
        ? TColors.colordarkgrey
        : TColors.colorprimaryLight;
    var height = MediaQuery.of(context).size.height;
    String fullImageUrl = ApiService.imageUrl;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: AppTextStyles.black20.copyWith(fontWeight: FontWeight.w600, color: colorsecondary),
        ),
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //       // Add button functionality here
        //     },
        //     child: Text("Select", style: TextStyle(color: TColors.colorprimaryLight, fontSize: 14)),
        //   ),
        // ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx( () =>
            Stack(
              children: [
                Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                              border: Border.all(
                                color: TColors.colorlightgrey,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: ClipOval(
                                child: Obx(
                                      () => CachedNetworkImage(
                                    imageUrl: "$fullImageUrl${controller.userImage.value}",
                                    placeholder: (context, url) => const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Center(child: Image.asset("assets/images/profile_dummy.png")),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Deliver to ${controller.userName.value}",
                            style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.w600, color: colorsecondary),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 200,
                        child: Obx(() {
                          if (controller.isCartEmpty.value) {
                            return const Center(
                              child: Text('No items in the cart.', style: TextStyle(fontSize: 16)),
                            );
                          } else {
                             return ListView.separated(
                              itemCount: controller.productsClaim.length,
                              separatorBuilder: (context, index) => const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                final product = controller.productsClaim[index];
                                String fullImageUrl = ApiService.imageUrl;
                                String imageUrl = "$fullImageUrl${product.image}";

                                double price = double.tryParse(product.price.replaceAll(',', '.')) ?? 0.0;

                                return Slidable(
                                  key: ValueKey(index),
                                  startActionPane: ActionPane(
                                    motion: const DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return DeleteDialog(
                                                onTap: () {
                                                  controller.deleteItem("${product.id}");
                                                  Get.back();
                                                  if (!controller.isCartEmpty.value){
                                                    controller.couponCode(
                                                      controller.couponCodeController.value.text,
                                                      controller.orderTotal.value,
                                                    );}
                                                },
                                              );
                                            },
                                          );
                                        },
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.red,
                                        image: const AssetImage(TImages.imgDeleteCart),
                                        autoClose: true,
                                        label: '',
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: background,
                                            borderRadius: BorderRadius.circular(15),
                                            border: Border.all(
                                              color: borderColor,
                                            ),
                                          ),
                                          child: Center(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                imageUrl: product.imageUrl,
                                                placeholder: (context, url) => const Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(20.0),
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                ),
                                                errorWidget: (context, url, error) => Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Center(child: Image.asset("assets/images/no-item-found.png")),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.title,
                                                style: AppTextStyles.black20.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: colorsecondary,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              Text(
                                                product.subtitle,
                                                style: AppTextStyles.grey12.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 11,
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "${price.toStringAsFixed(2)} €",
                                                style: AppTextStyles.black20.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: colorsecondary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller.decrementCount(index);
                                                controller.updateCartApi(product.id.toString(), product.count);
                                                if (!controller.isCartEmpty.value){
                                                  controller.couponCode(
                                                    controller.couponCodeController.value.text,
                                                    controller.orderTotal.value,
                                                  );}
                                                },
                                              child: SvgPicture.asset(TImages.iconminus),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '${product.count}',
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(width: 8),
                                            InkWell(
                                              onTap: () {
                                                controller.incrementCount(index);
                                                controller.updateCartApi(product.id.toString(), product.count);
                                                if (!controller.isCartEmpty.value){
                                                  controller.couponCode(
                                                    controller.couponCodeController.value.text,
                                                    controller.orderTotal.value,
                                                  );}
                                              },
                                              child: SvgPicture.asset(TImages.iconplus),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Have a coupon code? Enter here👇🏻",
                        style: AppTextStyles.grey12.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                     TextInputField(
                        height: 50,
                        controller: controller.couponCodeController.value,
                        backgroundColor: background,
                        hintText: "",
                        borderColor: Colors.transparent,
                        onTap: () {},
                      ),
                      const SizedBox(height: 15),
                      CommonAppButton(
                        width: double.infinity,
                        color: TColors.colorprimaryLight,
                        onPressed: () {
                          if (!controller.isCartEmpty.value){
                            controller.couponCode(
                              controller.couponCodeController.value.text,
                              controller.orderTotal.value,
                            );
                          }
                          else {
                            Get.snackbar("Can't Checkout", "Please add Product in your cart", duration: const Duration(seconds: 1));
                          }
                          },
                        buttonText: "Apply Coupon",
                      ),
                      const SizedBox(height: 10),
                      GestureDetector( onTap: (){
                        controller.launchInBrowser(Uri.parse('https://spa2.de/lieferbedingungen'));
                      },
                        child: Text(
                          "Shipping Amount",
                          style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.w600, color: colorsecondary),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                            () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSummaryItem(
                              title: "Subtotal",
                              value: "${controller.subtotal.value.toStringAsFixed(2)} €",
                              color: colorsecondary,
                            ),
                            _buildSummaryItem(
                              title: "Tax",
                              value: "${controller.tax.value.toStringAsFixed(2)} €", color: colorsecondary,
                            ),
                            _buildSummaryItem(
                              title: "Order Total",
                              value: "${controller.orderTotal.value.toStringAsFixed(2)} €",
                              isTotal: true, color: colorsecondary,
                            ),
                            if(controller.isCouponApplied.value)
                            _buildSummaryItem(
                              title: "Discounted Total",
                              value: "${controller.discountedTotal.value.toStringAsFixed(2)} €", color: colorsecondary,
                              isTotal: true,
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      CommonAppButton(
                        width: double.infinity,
                        color: TColors.colorprimaryLight,
                        onPressed: () {
                          if (!controller.isCartEmpty.value){
                            Get.toNamed(Routes.CHECKOUT_SHIPPING);
                            controller.savePreferences();
                          }
                          else {
                            Get.snackbar("Can't Checkout",
                                "Please add Product in your cart",
                                duration: const Duration(seconds: 1));
                          }


                        },
                        buttonText: "Checkout",
                      ),
                    ],
                  ),
                ),
                          ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
          child:  ShowLoader.isLoadingProgress(controller.isLoading.value),
        ),
              ],
            ),
        ),
      ),
    );

  }
Widget _buildSummaryItem({required String title, required String value, bool isTotal = false, required Color color,}) {
  final MyCartController controller = Get.find<MyCartController>(tag: 'cart');
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.grey12.copyWith(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        Text(
          controller.isCartEmpty.value ? '0.0  €' : value,
          style: AppTextStyles.black14.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: color,
          ),
        ),
      ],
    ),
  );
}
}
