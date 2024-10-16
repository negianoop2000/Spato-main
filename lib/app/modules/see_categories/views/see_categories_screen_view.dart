import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';

import '../../../../common/common_app_buttons.dart';
import '../../../../utils/constants/api_service.dart';
import '../../../../utils/constants/app_text_styles.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../data/model/category_productList.dart';
import '../../../routes/app_pages.dart';
import '../controllers/see_categories_screen_controller.dart';

class SeeCategoriesView extends GetView<SeeCategoriesController> {
  const SeeCategoriesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final SeeCategoriesController controller = Get.find<SeeCategoriesController>(tag: 'home');
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color searchicon= Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : Color(0xff4c5561);
    Color textFildBorder = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightunselectCheckbox
        : TColors.contanerBorderDark;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? Colors.transparent
        : TColors.darkerGrey;
    Color iconselected = Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : Colors.black;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.containerFill
        : TColors.black;
    Color iconUnselected = Theme.of(context).brightness == Brightness.light
        ? TColors.colordarkgrey
        : TColors.colorprimaryLight;
    final theme = Theme.of(context);
    var height = MediaQuery.of(context).size.height;
    String fullImageUrl = ApiService.imageUrl;
    return Scaffold(
      appBar: AppBar(
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
                child: Icon(Icons.arrow_back_ios, color: colorsecondary, size: 15),
              ),
            ),
          ),
        ),
        title: Obx(
              () {
            int selectedIndex = controller.selectedCategories.indexWhere((element) => element);
            String selectedCategoryText = selectedIndex != -1
                ? controller.categories[selectedIndex]
                : 'No Category Selected';

            return Text(
              "$selectedCategoryText",
              style: AppTextStyles.black20.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: colorsecondary,
              ),
            );
          },
        ),

        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: colorsecondary),
      ),
      body: SafeArea(
        child: Obx( () => Stack(
          children: [
            Container(height: height,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                        Obx(() => Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: List.generate(controller.categories.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                controller.toggleCategory(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: controller.selectedCategories[index]
                                      ? TColors.colorprimaryLight
                                      : TColors.colorprimaryLight.withOpacity(.10),
                                  borderRadius: BorderRadius.circular(38),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(height:36,width: 36,
                                        child: ClipOval(
                                          child: Image.asset(
                                            controller.imagescategori[index],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        controller.categories[index],
                                        style: AppTextStyles.black16.copyWith(
                                            fontWeight: FontWeight.w400, fontSize: 16, color: colorsecondary),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        )),
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                          child:Obx(() {
                            if (controller.products.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
                                child: Text(
                                  '',
                                  style: TextStyle(fontSize: 16, color: Colors.black54),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            } else {
                              return GridView.builder(
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.8,
                                ),
                                itemCount: controller.products.length,
                                itemBuilder: (context, index) {
                                  final product = controller.products[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.DETAIL_SCREEN,
                                        arguments: {
                                          'products': controller.products,
                                          'index': index,
                                        },
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: TColors.colorprimaryLight.withOpacity(.10),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                  child: product.imageUrl != null && product.imageUrl!.isNotEmpty
                                                      ? CachedNetworkImage(
                                                    imageUrl: product.imageUrl!,
                                                    placeholder: (context, url) => Center(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: CircularProgressIndicator(),
                                                      ),
                                                    ),
                                                    errorWidget: (context, url, error) => Center(
                                                        child: Image.asset("assets/images/no-item-found.png")),
                                                    fit: BoxFit.cover,
                                                  )
                                                      : Image.asset("assets/images/no-item-found.png"),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${product.artikelname}",
                                                    style: AppTextStyles.textTitleLight.copyWith(
                                                        color: TColors.colorlightgrey),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "⭐️",
                                                        style: AppTextStyles.textTitleMedium.copyWith(
                                                            fontWeight: FontWeight.w700, color: TColors.colorlightgrey),
                                                      ),
                                                      Text(
                                                        "${product.averageRating}",
                                                        style: AppTextStyles.textTitleMedium.copyWith(
                                                            fontWeight: FontWeight.w700, fontSize: 15, color: colorsecondary),
                                                      ),
                                                      Text(
                                                        "(${product.reviewCount})",
                                                        style: AppTextStyles.textTitleMedium.copyWith(
                                                            fontWeight: FontWeight.w700, color: TColors.colorlightgrey, fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${controller.formatPrice("${product.preisZzglMwSt}")}€",
                                                        style: AppTextStyles.textTitleMedium.copyWith(
                                                            fontWeight: FontWeight.w700, fontSize: 15, color: colorsecondary),
                                                      ),
                                                      Spacer(),
                                                      InkWell(
                                                        onTap: () {
                                                          print("Add to cart");
                                                          controller.addToCartApi("${product.id}");
                                                        },
                                                        child: SvgPicture.asset(
                                                          TImages.iconplus,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          })
                                    
                      ),
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
}
