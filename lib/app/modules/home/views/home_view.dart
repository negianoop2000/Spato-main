import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';

import '../../../../common/common_app_buttons.dart';
import '../../../../utils/theme/custom_themes/common_input_fields.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>(tag: 'home');
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color searchicon= Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : const Color(0xff4c5561);
    Color textFildBorder = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightunselectCheckbox
        : TColors.contanerBorderDark;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? Colors.transparent
        : TColors.darkerGrey;
    Color iconselected = Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : Colors.black;
    Color iconUnselected = Theme.of(context).brightness == Brightness.light
        ? TColors.colordarkgrey
        : TColors.colorprimaryLight;
    var height = MediaQuery.of(context).size.height;
    String fullImageUrl = ApiService.imageUrl;
    return Scaffold(

      body: SafeArea(
        child: Obx( () => Stack(
            children: [
              GestureDetector(
                onTap: (){
                  controller.searchController.value.clear();
                  controller.isSelectedFiltered.value = false;
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  controller.userName.value,
                                    style: AppTextStyles.grey16.copyWith(
                                        fontWeight: FontWeight.w700, fontSize: 22, color: TColors.colorprimaryLight),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              height: 50,
                              width: 50,
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
                                          errorWidget: (context, url, error) => Container(),
                                          fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Obx(() => TextInputField(
                          height: 50,
                          controller: controller.searchController.value,
                          prefixIcon: SvgPicture.asset(
                            TImages.imgsearchgrey, color: searchicon,
                          ),
                          hintText: "I’m searching for",
                          hintStyle:  AppTextStyles.textTitleLight.copyWith(color: colorsecondary,fontSize: 12),
                          borderColor: textFildBorder,
                          onTap: () {},
                        )),
                        Obx(() => Visibility(
                          visible: controller.searchController.value.text.isNotEmpty,
                          child: controller.isLoading.value
                              ? const SizedBox(height: 1,)

                              : controller.searchResults.isEmpty
                              ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('No results found'),
                            ),
                          )
                              : Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(height: 200, decoration: BoxDecoration(
                                color: TColors.colorprimaryLight.withOpacity(.10),
                                  borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Scrollbar(
                                  child: ListView.builder(
                                    itemCount: controller.searchResults.length,
                                    itemBuilder: (context, index) {
                                      final product = controller.searchResults[index];
                                      return ListTile(
                                        title: Text(product.artikelname ?? 'No Name',   style: AppTextStyles.textTitleLight.copyWith(color: TColors.colorlightgrey),overflow: TextOverflow.ellipsis,maxLines: 2
                                        ),
                                        onTap: () {
                                          // Debug print statements
                                          print('Selected index: $index');
                                          print('Search results length: ${controller.searchResults.length}');
                                          print('Products length: ${controller.products.length}');

                                          // Ensure index is valid
                                          if (index >= 0 && index < controller.searchResults.length) {
                                            Get.toNamed(
                                              Routes.DETAIL_SCREEN,
                                              arguments: {
                                                'products': controller.searchResults, // Use searchResults instead of products
                                                'index': index,
                                              },
                                            );
                                          } else {
                                            print('Index out of bounds');
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                                                          ),
                                                        ),
                              ),
                        )),
                        const SizedBox(height: 12),
                        Obx(() {
                          if (controller.bannerImage.value.isNotEmpty) {
                            return Container(
                              height: 220,
                              decoration: BoxDecoration(
                                color: TColors.colorprimaryLight.withOpacity(.10),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Specialist Wholesaler for Pools and Equipments", style: AppTextStyles.black20.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 8,
                                            color: colorsecondary,
                                          ),),
                                          Text(controller.bannerContained.value, style: AppTextStyles.black20.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10,
                                            color: colorsecondary,
                                          ),),
                                          Text("Click & buy SPATO spare parts tool", style: AppTextStyles.black20.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 8,
                                            color: colorsecondary,
                                          ),),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text("40K+", style: AppTextStyles.black20.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    color: colorsecondary,
                                                  ),),
                                                  Text("Order Completed", style: AppTextStyles.black20.copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 8,
                                                    color: colorsecondary,
                                                  ),),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text("15K+", style: AppTextStyles.black20.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    color: colorsecondary,
                                                  ),),
                                                  Text("Satisfied Client", style: AppTextStyles.black20.copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 8,
                                                    color: colorsecondary,
                                                  ),),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: "${fullImageUrl}mobile_app/banner_image/${controller.bannerImage.value}",
                                          placeholder: (context, url) => const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(20.0),
                                              child: CircularProgressIndicator(),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) => Center(
                                            child: Image.asset("assets/images/no-item-found.png"),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }),



                        const SizedBox(height: 12),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.ALL_CATEGORY);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: colorsecondary),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            "See Categories",
                                            style: AppTextStyles.black20.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                              color: colorsecondary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                               const SizedBox(width: 50,),
                                InkWell(
                                  onTap: () {
                                    controller.isSelectedFiltered.value = !controller.isSelectedFiltered.value;
                                    print("Filter toggled: ${controller.isSelectedFiltered.value}");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: colorsecondary),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Filter",
                                            style: AppTextStyles.black20.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                              color: colorsecondary,
                                            ),
                                          ),
                                          Icon(Icons.keyboard_arrow_down_outlined, color: colorsecondary,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            Obx(() {
                              print("Rebuilding widget. isSelectedFiltered: ${controller.isSelectedFiltered.value}");
                              return controller.isSelectedFiltered.value
                                  ? Container(
                                decoration: const BoxDecoration(
                                //  color: TColors.colorprimaryLight.withOpacity(.10),
                                //  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height:10),
                                    Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: TColors.colorprimaryLight.withOpacity(.10),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Obx(() {
                                        return Scrollbar(
                                          child: ListView.builder(
                                            itemCount: controller.options.length,
                                            itemBuilder: (context, index) {
                                              final option = controller.options[index];
                                              return Obx(() {
                                                final isSelected = controller.selectedOptions.contains(option);
                                                return ListTile(
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 1.0),
                                                  leading: Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: colorsecondary),
                                                      borderRadius: BorderRadius.circular(4),
                                                      color: isSelected ? colorsecondary : Colors.transparent,
                                                    ),
                                                    child: Center(
                                                      child: isSelected
                                                          ? Icon(Icons.check, size: 16, color: iconselected,)
                                                          : null,
                                                    ),
                                                  ),
                                                  title: Text(
                                                    option,
                                                    style: AppTextStyles.black20.copyWith(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 20,
                                                      color: colorsecondary,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    controller.toggleOption(option);
                                                    print("Option toggled: $option, selectedOptions: ${controller.selectedOptions}");
                                                  },
                                                );
                                              });
                                            },
                                          ),
                                        );
                                      }),
                                    ),
                                    const SizedBox(height:10),
                                    CommonAppButton(
                                      width: double.infinity,
                                      color: TColors.colorprimaryLight,
                                      onPressed: () {
                                        controller.saveSelectedOptions();
                                        controller.isSelectedFiltered.value = false;
                                      },
                                      buttonText: "See Categories",
                                    ),
                                  ],
                                ),
                              )
                                  : const SizedBox.shrink();
                            }),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                            height: height*0.4,
                            child:Obx(() {
                      if (controller.products.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 20,left: 40,right: 40),
                          child: Text(
                            '',
                            style: TextStyle(fontSize: 16, color: Colors.black54),textAlign: TextAlign.center,
                          ),
                        );
                      } else {
                        return
                          GridView.builder(
                          shrinkWrap: true,
                          //physics: NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) {
                            if (index >= controller.products.length) {
                              // Check if index is valid
                              return const Center(child: Text('Invalid item index'));
                            }

                            final product = controller.products[index];
                           // String fullImageUrl = ApiService.imageUrl;
                           // String imageUrl = "$fullImageUrl${product.bild1 ?? ''}";

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
                                            child:  CachedNetworkImage(
                                              imageUrl: product.bild1!,
                                              placeholder: (context, url) => const Center(
                                                child: Padding(
                                                  padding: EdgeInsets.all(20.0),
                                                  child: CircularProgressIndicator(),
                                                ),
                                              ),
                                             errorWidget: (context, url, error) => Center(child: Image.asset("assets/images/no-item-found.png")),
                                              fit: BoxFit.cover,
                                            )
                                              //  : Image.asset("assets/images/no-item-found.png"),
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
                                              style: AppTextStyles.textTitleLight.copyWith(color: TColors.colorlightgrey),overflow: TextOverflow.ellipsis,maxLines: 2
                                            ),
                                            const SizedBox(height: 4),
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
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Text(
                                                  "${controller.formatPrice("${product.preisZzglMwSt}")}€",
                                                  style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w700, fontSize: 15, color: colorsecondary),
                                                ),
                                                const Spacer(),
                                                InkWell(onTap: () {
                                                  print("Add to card");
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
                    })),
                        if(controller.bundleproducts.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text("Bundle products",style: TextStyle(fontSize: 25,color: colorsecondary),),
                        ),
                        Obx(() {
                          if (controller.bundleproducts.isEmpty) {
                            return const Text(
                              '',
                              style: TextStyle(fontSize: 16, color: Colors.black54),textAlign: TextAlign.center,
                            );
                          } else {
                            return
                              SizedBox(
                                height: height*0.4,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.8,
                                  ),
                                  itemCount: controller.bundleproducts.length,
                                  itemBuilder: (context, index) {
                                    if (index >= controller.bundleproducts.length) {
                                      return const Center(child: Text('Invalid item index'));
                                    }
                                    final bundleprod = controller.bundleproducts[index];
                                   return InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.DETAIL_SCREEN,
                                          arguments: {
                                            'products': controller.bundleproducts,
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
                                                    child: CachedNetworkImage(
                                                      imageUrl: bundleprod.bild1!,
                                                      placeholder: (context, url) => const Center(
                                                        child: Padding(
                                                          padding: EdgeInsets.all(20.0),
                                                          child: CircularProgressIndicator(),
                                                        ),
                                                      ),
                                                      errorWidget: (context, url, error) => Center(child: Image.asset("assets/images/no-item-found.png")),
                                                      fit: BoxFit.cover,
                                                    )
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "${bundleprod.artikelname}",
                                                        style: AppTextStyles.textTitleLight.copyWith(color: TColors.colorlightgrey),overflow: TextOverflow.ellipsis,maxLines: 2
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "⭐️",
                                                          style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w700, color: TColors.colorlightgrey),
                                                        ),
                                                        Text(
                                                          "${bundleprod.averageRating}",
                                                          style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w700, fontSize: 15, color: colorsecondary),
                                                        ),
                                                        Text(
                                                          "(${bundleprod.reviewCount})",
                                                          style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w700, color: TColors.colorlightgrey, fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "${controller.formatPrice("${bundleprod.preisZzglMwSt}")}€",
                                                          style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w700, fontSize: 15, color: colorsecondary),
                                                        ),
                                                        const Spacer(),
                                                        InkWell(onTap: () {
                                                          print("Add to card");
                                                          controller.addToCartApi("${bundleprod.id}");
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
                                ),
                              );
                          }
                        }),
                      ],
                    ),
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
