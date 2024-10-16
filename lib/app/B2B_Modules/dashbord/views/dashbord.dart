import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/app/B2B_Modules/dashbord/controllers/dashbord.dart';
import 'package:spato_mobile_app/app/B2B_Modules/drawer_b2b.dart';
import 'package:spato_mobile_app/common/bottomNavigationTap.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';




class DashboardB2BView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DashboardB2BController controller = Get.find<DashboardB2BController>();
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.containerFill
        : TColors.black;
    Color background2 = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;

    return Scaffold(
      //  drawer: Drawer_B2B(),
      appBar: AppBar(
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
                  color: borderColor, // Replace AppColors.CommanGrey
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.arrow_back_ios, color: colorsecondary, size: 15),
              ),
            ),
          ),
        ),
        title: Obx(() => Text(controller.title.value, style: AppTextStyles.black20.copyWith(fontWeight: FontWeight.w600, color: colorsecondary))),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
                child:  ShowLoader.isLoadingProgress(controller.isLoading.value),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 1,
                      ),
                      itemCount: controller.b2bdashbord.length,
                      itemBuilder: (context, index) {
                        final product = controller.b2bdashbord[index];
                        return InkWell(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.toNamed(Routes.OFFER_B2B_SCREEN);
                                break;
                              case 1:
                                Get.toNamed(Routes.ORDER_B2B_SCREEN);
                                break;
                              case 2:
                                Get.toNamed(Routes.BILLS_SCREEN);
                                break;
                              case 3:
                                Get.toNamed(Routes.CREDIT_NOTES_SCREEN);
                                break;
                              case 4:
                                Get.toNamed(Routes.NEEDHELP_SCREEN);
                                break;
                              case 5:
                                Get.toNamed(Routes.DEALMAKER_SCREEN);
                                break;
                              case 6:
                                Get.toNamed(Routes.ADDRESSBOOK_SCREEN);
                                break;
                              default:
                                Get.toNamed(Routes.DASHBORD_B2B);
                                break;
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: TColors.colorprimaryLight.withOpacity(.10),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: Image.asset(
                                      product.icon,
                                      height: 32,
                                      width: 32, // Make sure the width is the same as height for a perfect circle
                                      fit: BoxFit.cover, // Ensures the image covers the entire oval area
                                    ),
                                  ),

                                  SizedBox(height: 15),
                                  Text(
                                    product.text,
                                    style: AppTextStyles.grey16.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: colorsecondary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Obx(() => Text(
                                        product.count.value.toString(),
                                        style: AppTextStyles.grey16.copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 22,
                                            color: TColors.colorprimaryLight),
                                      )),
                                      Icon(Icons.arrow_forward),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
