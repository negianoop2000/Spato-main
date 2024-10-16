import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/app/data/model/category_productList.dart';
import 'package:spato_mobile_app/app/data/model/products_list.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';

import '../controllers/all_product_controller.dart';

class AllProductView extends StatelessWidget {
  AllProductView({Key? key}) : super(key: key);

  final AllProductController controller = Get.put(AllProductController());

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = Get.arguments ?? {};
    String selectedCategory = arguments['category'] ?? "Pools";
    List<ProductList> products = arguments['products'] ?? [];
    String selectedImage = arguments['image'] ?? ""; // Extract selected image

    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.containerFillDark
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;

    controller.setProducts(products);
    controller.setSelectedImage(selectedImage); // Set the selected image

    return Scaffold(
      appBar: AppBar(
        title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Products",
                style: AppTextStyles.black16.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: colorsecondary,
                ),),
          ],
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return
                      Center(
                      child:  Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
                        child:  ShowLoader.isLoadingProgress(controller.isLoading.value),
                      ),
                    );
                  } else
                    if (controller.products.isEmpty) {
                    return Center(
                      child: Text(
                        '',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    );
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) {
                        final product = controller.products[index];
                        String fullImageUrl = ApiService.imageUrl;
                        String imageUrl = "$fullImageUrl${product.bild1}";

                        return InkWell(
                          onTap: () {
                            print('Selected index: $index');
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
                                          imageUrl: product.bild1!,
                                          placeholder: (context, url) => Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: CircularProgressIndicator(),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) => Center(child: Image.asset("assets/images/no-item-found.png")),
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
                                          style: AppTextStyles.textTitleLight.copyWith(color: TColors.colorlightgrey),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              "⭐️",
                                              style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w700, color: TColors.colorlightgrey),
                                            ),
                                            Text(
                                              "${product.averageRating}",
                                              style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w700, fontSize: 15, color: colorsecondary),
                                            ),
                                            Text(
                                              "(${product.reviewCount})",
                                              style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w700, color: TColors.colorlightgrey, fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              "${controller.formatPrice("${product.preisZzglMwSt}")}€",
                                              style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w700, fontSize: 15, color: colorsecondary),
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
                }),
              ),
            ],
          ),
        ),
      ),

    );
  }
}


