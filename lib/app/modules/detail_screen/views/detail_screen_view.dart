import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/common/common_app_buttons.dart';
import 'package:spato_mobile_app/common/ratingbar.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';

import '../../../../utils/constants/api_service.dart';
import '../controllers/detail_screen_controller.dart';

class DetailScreenView extends StatelessWidget {

  final DetailScreenController controller = Get.put(DetailScreenController());
  final ScrollController _scrollController = ScrollController();
  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    print("4895236665856566");
    print(controller.productDetail.value.preisZzglMwSt ?? '');
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey.withOpacity(0.1)
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;

    // Color colorsecondary = Theme.of(context).brightness == Brightness.light
    //     ? TColors.colorsecondaryLight
    //     : TColors.colorsecondaryDark;
    // Color background = Theme.of(context).brightness == Brightness.light
    //     ? TColors.containerFill
    //     : TColors.black;
    // Color borderColor = Theme.of(context).brightness == Brightness.light
    //     ? TColors.colorlightgrey
    //     : TColors.darkerGrey;
    final product = controller.productDetail.value;
    return SafeArea(
      child: Scaffold(

        //
        appBar: AppBar(
          title: Text(TTexts.txtProductDetail, style: AppTextStyles.black20.copyWith(fontWeight: FontWeight.w600,color: colorsecondary)),
          leading: InkWell(
            onTap: () {
           Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child:  Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: background ,
                    border: Border.all(
                      color: borderColor, // Replace AppColors.CommanGrey
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(Icons.arrow_back_ios,color: colorsecondary,size: 15,),
                  )
              ),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Get.toNamed(
                  Routes.REQUEST_QUOTE_SCREEN,
                  arguments: {
                    "productID": controller.productDetail.value.id?.toString() ?? '',
                    "productCode": controller.productDetail.value.katalogArtNummer ?? '',
                  },
                );


              },
              child: Padding(

                padding: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(TImages.iconmoreicon,width: 35,height: 35,color: colorsecondary,),
              ),
            ),
          ],
          centerTitle: true,
        ),

        bottomNavigationBar: Obx( () => SizedBox(height: 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,bottom: 18),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () => controller.decrementCount(),
                          child: SvgPicture.asset(TImages.iconminus,height: 30,width: 30,),
                        ),
                        Text(
                          controller.productQuantitycount.toString().padLeft(2, '0'),
                          style: const TextStyle(fontSize: 16),
                        ),
                        InkWell(
                          onTap: () => controller.incrementCount(),
                          child: SvgPicture.asset(TImages.iconplus,height: 30,width: 30,),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CommonAppButton(
                      width: double.infinity,
                      color: TColors.colorprimaryLight,
                      onPressed: () {
                       controller.addToCartApi("${controller.productDetail.value.id ?? ''}");
                      },
                      buttonText: "Add to Cart",

                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body:  Obx(() {

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: TColors.colorlightgrey.withOpacity(.10),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: TColors.colorlightgrey, // Replace AppColors.CommanGrey
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 30,
                              left: 60,
                              bottom: 30,
                              right: 60,
                              child: PageView.builder(
                                controller: controller.pageController,
                                itemCount: controller.images.length,
                                onPageChanged: (int index) {
                                  controller.currentPage = index;
                                },
                                itemBuilder: (context, index) {
                                  String imageUrl = controller.images[index];
                                  return CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    placeholder: (context, url) => const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Center(child: Image.asset("assets/images/no-item-found.png")),
                                    fit: BoxFit.contain,
                                  );
                                },
                              )
                            ),
                            Positioned(
                              bottom: 20,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: SmoothPageIndicator(
                                  controller: controller.pageController,
                                  count: controller.images.length,
                                  effect: const WormEffect(
                                    dotHeight: 8,
                                    dotWidth: 8,
                                    activeDotColor: TColors.colorsecondaryLight, // Customize as needed
                                    dotColor: TColors.colorlightgrey, // Customize as needed
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                        CommonAppButton(
                        width: 143,
                        height: 26,
                        borderRadius: 8,
                        color: controller.productDetail.value.availStatus == "Auf Lager"
                            ? TColors.colorGreenShine
                            : TColors.error,
                        onPressed: () {
                        },
                        buttonText: controller.productDetail.value.availStatus == "Auf Lager"
                            ? "Available In Stock"
                            : "Not Available In Stock",
                        btnTextStyle: AppTextStyles.textTitleLight.copyWith(fontSize: 13),
                      ),
                          const Spacer(),
                          Column(
                            children: [
                                Text("Exclusive VAT -",
                                    style: AppTextStyles.textHeadingTitle.copyWith(fontSize: 12,
                                        fontWeight: FontWeight.w400,color: colorsecondary)
                                ),
                              Text("${controller.formatPrice(controller.productDetail.value.preisZzglMwSt ?? '')}€",
                                  style: AppTextStyles.textHeadingTitle.copyWith(fontSize: 19,
                                      fontWeight: FontWeight.w600,color: colorsecondary)
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Align(alignment: Alignment.topLeft,
                        child: Text(
                            controller.productDetail.value.artikelname ?? '',
                            style: AppTextStyles.black24.copyWith(fontSize: 22,
                                fontWeight: FontWeight.w600,color: colorsecondary)
                        ),
                      ),
                      const SizedBox(height: 5,),
                      // Row(
                      //   children: [
                      //     Text("⭐️", style: AppTextStyles.black16.copyWith(fontWeight: FontWeight.w700)),
                      //     Text("${controller.productDetail.value.artikelname ?? ''}", style: AppTextStyles.black16.copyWith(fontWeight: FontWeight.w700,color: colorsecondary)),
                      //     Text("(${controller.productDetail.value.artikelname ?? ''})", style: AppTextStyles.grey16.copyWith(fontWeight: FontWeight.w700)),
                      //
                      //   ],
                      // ),
                      Align(alignment: Alignment.topLeft,child: Text("Product code - ${controller.productDetail.value.herstellerArtikelnummer ?? ''}", style: AppTextStyles.grey16.copyWith(fontWeight: FontWeight.w700,color: colorsecondary))),
                      const SizedBox(height: 5,),
                      Align(alignment: Alignment.topLeft,child: Text("Product info", style: AppTextStyles.black20.copyWith(fontSize: 17, fontWeight: FontWeight.w600,color: colorsecondary))),
                      const SizedBox(height: 5,),
                      Align(alignment: Alignment.topLeft,child: Text(controller.productDetail.value.beschreibungKurz ?? '', style: AppTextStyles.grey14.copyWith(fontWeight: FontWeight.w400,color: colorsecondary))),
                      const SizedBox(height: 20),
                      Obx(() => GestureDetector(
                        onTap: () {
                          controller.toggleExpandedDetail(); // Use the toggle method to change the value
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: TColors.colorprimaryLight.withOpacity(.10),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: TColors.colorlightgrey,
                            ),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: SvgPicture.asset(
                                  TImages.iconProdcutdetail,
                                  color: colorsecondary,
                                ),
                                title: Text(
                                  "Product Details",
                                  style: TextStyle(color: colorsecondary, fontSize: 14),
                                ),
                                trailing: Obx(() => SvgPicture.asset(
                                  controller.isExpandedDetail.value ? TImages.iconarrowDown : TImages.iconarrowforward,
                                  color: colorsecondary,
                                )),
                              ),
                              if (controller.isExpandedDetail.value) // Check value of isExpandedDetail
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Product info :",
                                        style: AppTextStyles.black16.copyWith(fontWeight: FontWeight.w600,color: colorsecondary),
                                      ),
                                      const SizedBox(height: 4,),
                                      Text(
                                        controller.productDetail.value.beschreibungLang ?? '',
                                        style: AppTextStyles.grey14,
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      )),
                      if(controller.spareParts.isNotEmpty)
                      const SizedBox(height: 20),
                      if(controller.spareParts.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          controller.navigate_sparePartDetail();
                          },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: TColors.colorprimaryLight.withOpacity(.10),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: TColors.colorlightgrey, // Replace AppColors.CommanGrey
                            ),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: SvgPicture.asset(
                                  "assets/icons/imgAddress.svg" ,color: colorsecondary,
                                ),
                                title: Text("Go to Spare parts", style: TextStyle(color: colorsecondary, fontSize: 14)), // Replace AppTextStyles.black14
                                trailing: SvgPicture.asset(
                                   TImages.iconarrowforward, color: colorsecondary,// Change the arrow icon
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          controller.toggleSpacification();
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: TColors.colorprimaryLight.withOpacity(.10),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: TColors.colorlightgrey, // Replace AppColors.CommanGrey
                            ),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: SvgPicture.asset(
                                  TImages.iconsparepart ,color: colorsecondary,
                                ),
                                title: Text("Product Specification", style: TextStyle(color: colorsecondary, fontSize: 14)), // Replace AppTextStyles.black14
                                trailing: SvgPicture.asset(
                                  controller.isExpandedSpacification.value ? TImages.iconarrowDown : TImages.iconarrowforward, color: colorsecondary,// Change the arrow icon
                                ),
                              ),
                              if (controller.isExpandedSpacification.value)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Divider(
                                        color: TColors.grey,height: 8,thickness: 1,
                                      ),
                                      if(controller.productDetail.value.einheit!= null)
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text("Einheit/Unit",style:AppTextStyles.grey14.copyWith(

                                            ),),
                                          ),
                                          const SizedBox(width: 10,),
                                          Text(controller.productDetail.value.einheit ?? '',style:AppTextStyles.grey14.copyWith(

                                          ),),
                                        ],
                                      ),
                                      if(controller.productDetail.value.einheit!= null)
                                      const Divider(
                                        color: TColors.grey,height: 8,thickness: 1,
                                      ),
                                      if(controller.productDetail.value.veVpe!= null)
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text("VE/VPE",style:AppTextStyles.grey14.copyWith(

                                            ),),
                                          ),
                                          const SizedBox(width: 10,),
                                          Text(controller.productDetail.value.veVpe ?? '',style:AppTextStyles.grey14.copyWith(

                                          ),),
                                        ],
                                      ),
                                      if(controller.productDetail.value.veVpe!= null)
                                      const Divider(
                                        color: TColors.grey,height: 8,thickness: 1,
                                      ),
                                      if(controller.productDetail.value.material!= null)
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text("Material",style:AppTextStyles.grey14.copyWith(

                                            ),),
                                          ),
                                          const SizedBox(width: 10,),
                                          Text(controller.productDetail.value.material ?? '',style:AppTextStyles.grey14.copyWith(

                                          ),),
                                        ],
                                      ),
                                      if(controller.productDetail.value.material!= null)
                                      const Divider(
                                        color: TColors.grey,height: 8,thickness: 1,
                                      ),
                                      if(controller.productDetail.value.m3H!= null)
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text("m3/h",style:AppTextStyles.grey14.copyWith(

                                              ),),
                                            ),
                                            const SizedBox(width: 10,),
                                            Text(controller.productDetail.value.m3H ?? '',style:AppTextStyles.grey14.copyWith(

                                            ),),
                                          ],
                                        ),
                                      if(controller.productDetail.value.m3H!= null)
                                        const Divider(
                                          color: TColors.grey,height: 8,thickness: 1,
                                        ),
                                      if(controller.productDetail.value.gewicht!= null)
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text("Weight Kg",style:AppTextStyles.grey14.copyWith(

                                            ),),
                                          ),
                                          const SizedBox(width: 10,),
                                          Text(controller.productDetail.value.gewicht ?? '',style:AppTextStyles.grey14.copyWith(

                                          ),),
                                        ],
                                      ),
                                      if(controller.productDetail.value.gewicht!= null)
                                      const Divider(
                                        color: TColors.grey,height: 8,thickness: 1,
                                      ),
                                      if(controller.productDetail.value.lange!= null)
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text("Length mm",style:AppTextStyles.grey14.copyWith(

                                            ),),
                                          ),
                                          const SizedBox(width: 10,),
                                          Text(controller.productDetail.value.lange ?? '',style:AppTextStyles.grey14.copyWith(

                                          ),),
                                        ],
                                      ),
                                      if(controller.productDetail.value.lange!= null)
                                      const Divider(
                                        color: TColors.grey,height: 8,thickness: 1,
                                      ),
                                      if(controller.productDetail.value.breite!= null)
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text("Width mm",style:AppTextStyles.grey14.copyWith(

                                            ),),
                                          ),
                                          const SizedBox(width: 10,),
                                          Text(controller.productDetail.value.breite ?? '',style:AppTextStyles.grey14.copyWith(

                                          ),),
                                        ],
                                      ),
                                      if(controller.productDetail.value.breite!= null)
                                      const Divider(
                                        color: TColors.white,height: 8,thickness: 1,
                                      ),

                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          controller.toggleExpandedDownload(); // Use the toggle method to change the value
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: TColors.colorprimaryLight.withOpacity(.10),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: TColors.colorlightgrey,
                            ),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: SvgPicture.asset(
                                  TImages.iconhdownaloadinfo,
                                  color: colorsecondary,
                                ),
                                title: Text(
                                    "Download Information",
                                    style: TextStyle(color: colorsecondary, fontSize: 14)
                                ),
                                trailing: SvgPicture.asset(
                                  controller.isExpandedDownload.value
                                      ? TImages.iconarrowDown
                                      : TImages.iconarrowforward,
                                  color: colorsecondary,
                                ),
                              ),
                              if (controller.isExpandedDownload.value)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if ((controller.productDetail.value.anleitungPdf1?.isEmpty ?? true) &&
                                          (controller.productDetail.value.anleitungPdf2?.isEmpty ?? true) &&
                                          (controller.productDetail.value.anleitungPdf3?.isEmpty ?? true))
                                        const Padding(
                                          padding: EdgeInsets.symmetric(vertical: 16.0),
                                          child: Center(
                                            child: Text(
                                              "No Documents",
                                              style: TextStyle(
                                                color: TColors.colorlightgrey,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        )
                                      else ...[
                                        if (controller.productDetail.value.anleitungPdf1?.isNotEmpty ?? false)
                                          Column(
                                            children: [
                                              const Divider(
                                                color: TColors.white,
                                                height: 8,
                                                thickness: 1,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  controller.launchInBrowser(Uri.parse('https://spa2.de/storage/${controller.productDetail.value.anleitungPdf1}'));
                                                },
                                                child: Row(
                                                  children: [
                                                    const Icon(Icons.file_copy_outlined, color: TColors.colorlightgrey, size: 14),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        "${controller.productDetail.value.anleitungPdf1}",
                                                        style: AppTextStyles.grey14.copyWith(
                                                          decoration: TextDecoration.underline,
                                                          decorationColor: TColors.colorlightgrey,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        if (controller.productDetail.value.anleitungPdf2?.isNotEmpty ?? false)
                                          Column(
                                            children: [
                                              const Divider(
                                                color: TColors.white,
                                                height: 8,
                                                thickness: 1,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  controller.launchInBrowser(Uri.parse('https://spa2.de/storage/${controller.productDetail.value.anleitungPdf2}'));
                                                },
                                                child: Row(
                                                  children: [
                                                    const Icon(Icons.file_copy_outlined, color: TColors.colorlightgrey, size: 14),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        "${controller.productDetail.value.anleitungPdf2}",
                                                        style: AppTextStyles.grey14.copyWith(
                                                          decoration: TextDecoration.underline,
                                                          decorationColor: TColors.colorlightgrey,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        if (controller.productDetail.value.anleitungPdf3?.isNotEmpty ?? false)
                                          Column(
                                            children: [
                                              const Divider(
                                                color: TColors.white,
                                                height: 8,
                                                thickness: 1,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  controller.launchInBrowser(Uri.parse('https://spa2.de/storage/${controller.productDetail.value.anleitungPdf3}'));
                                                },
                                                child: Row(
                                                  children: [
                                                    const Icon(Icons.file_copy_outlined, color: TColors.colorlightgrey, size: 14),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        "${controller.productDetail.value.anleitungPdf3}",
                                                        style: AppTextStyles.grey14.copyWith(
                                                          decoration: TextDecoration.underline,
                                                          decorationColor: TColors.colorlightgrey,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),


                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: TColors.colorprimaryLight.withOpacity(.10),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: TColors.colorlightgrey,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Rating and stars
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${controller.rating.toStringAsFixed(1)}/5.0",
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  StarDisplay(value: controller.rating.value), // Display stars
                                ],
                              ),
                            ),
                            // Composition bars
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: List.generate(5, (index) {
                                    return RatingBarComposition(
                                      starLevel: 5 - index,
                                      totalReviews: controller.totalReviews,
                                      rating: controller.rating.value,
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      const SizedBox(height: 20),
                      Obx(() => GestureDetector(
                        onTap: () {
                          controller.toggleExpandedReview(); // Use the toggle method to change the value
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: TColors.colorprimaryLight.withOpacity(.10),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: TColors.colorlightgrey,
                            ),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: SvgPicture.asset(
                                  TImages.iconreviewblkack,
                                  color: colorsecondary,
                                ),
                                title: Text(
                                  "Review",
                                  style: TextStyle(color: colorsecondary, fontSize: 14),
                                ),
                                trailing: Obx(() => SvgPicture.asset(
                                  controller.isExpandedReview.value ? TImages.iconarrowDown : TImages.iconarrowforward,
                                  color: colorsecondary,
                                )),
                              ),
                              if (controller.isExpandedReview.value) // Check value of isExpandedReview
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Your overall rating of this product",
                                          style: AppTextStyles.grey14.copyWith(color: colorsecondary),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.center,
                                        child: RatingStars(
                                          value: controller.ratingSubmit.value, // Use controller.rating.value to access the observable value
                                          onValueChanged: (v) {
                                            controller.ratingSubmit.value = v; // Update observable value
                                          },
                                          starBuilder: (index, color) => Icon(
                                            Icons.star,
                                            color: color,
                                          ),
                                          starCount: 5,
                                          starSize: 35.0,
                                          maxValue: 5,
                                          starSpacing: 2.0,
                                          maxValueVisibility: true,
                                          valueLabelVisibility: false,
                                          animationDuration: const Duration(milliseconds: 1000),
                                          valueLabelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                                          valueLabelMargin: const EdgeInsets.only(right: 8),
                                          starOffColor: TColors.colorlightgrey,
                                          starColor: Colors.yellow,
                                          valueLabelColor: TColors.colorTransparent,
                                          valueLabelTextStyle: AppTextStyles.grey16.copyWith(color: Colors.transparent),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Write your feedback here:",
                                        style: AppTextStyles.black16.copyWith(color: colorsecondary),
                                      ),
                                      const SizedBox(height: 8),
                                      TextInputField(
                                        maxLines: 4,
                                        maxLength: 250,
                                        height: 150,
                                        controller: controller.reviewController,
                                        hintText: "Type here...",
                                        onTap: () {},
                                      ),
                                      const SizedBox(height: 8),
                                      CommonAppButton(
                                        width: double.infinity,
                                        color: TColors.colorprimaryLight,
                                        onPressed: () {
                                          print("Rating: ${controller.ratingSubmit.value}");
                                          print("Feedback: ${controller.reviewController.text}");
                                          controller.reviewRating("${controller.ratingSubmit.value}", controller.reviewController.text,"${controller.productDetail.value.id ?? ''}");
                                        },
                                        buttonText: "Submit",
                                        btnTextStyle: AppTextStyles.textTitleMedium.copyWith(fontSize: 17),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      )),
                      const SizedBox(height: 20),
                      if(controller.review.isNotEmpty)
                      Row(
                        children: [
                          Text(
                            "Reviews",
                            style: AppTextStyles.black20.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w600, color: colorsecondary),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              if (controller.review.isNotEmpty) {
                                Get.toNamed(Routes.ALL_REVIEW, arguments: {'products': controller.review});
                              }
                            },
                            child: Row(
                              children: [
                                Text(
                                  "See All",
                                  style: AppTextStyles.textTitleMedium.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: TColors.colorprimaryLight,
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                SvgPicture.asset(
                                  TImages.iconForwardThemem,
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: 20),
                      if(controller.productsClam.isNotEmpty)
                      Align(alignment: Alignment.topLeft,
                        child: Text(
                            "Package",
                            style: AppTextStyles.black20.copyWith(fontSize: 20,
                                fontWeight: FontWeight.w600,color: colorsecondary)
                        ),
                      ),
                      if(controller.productsClam.isNotEmpty)
                      Align(alignment: Alignment.topLeft,
                        child: Text(
                            "You can take advantage of the offer",
                            style: AppTextStyles.black16.copyWith(fontSize: 16,
                                fontWeight: FontWeight.w400,color: colorsecondary)
                        ),
                      ),
                      if(controller.productsClam.isNotEmpty)
                      const SizedBox(height: 20),
                      if(controller.productsClam.isNotEmpty)
                      // Container(height: 200,
                      //   child: ListView.separated(
                      //     itemCount: controller.productsClam.length,
                      //     separatorBuilder: (context, index) => SizedBox(height: 8),
                      //     itemBuilder: (context, index) {
                      //       final product = controller.productsClam[index];
                      //       String fullImageUrl = ApiService.imageUrl;
                      //       String imageUrl = controller.images[index];
                      //       if (imageUrl.isNotEmpty && !imageUrl.contains('default_image.jpg')) {
                      //         imageUrl = '$fullImageUrl$imageUrl';
                      //       } else {
                      //         imageUrl = 'assets/images/default_image.jpg'; // Fallback image
                      //       }
                      //       return GestureDetector(
                      //         onTap: (){
                      //           print("dsgdsg${product.id }${product.kategorie1}");
                      //           if (product.id != null && product.kategorie1 != null) {
                      //             controller.getDetailPageApi(product.id!, product.kategorie1!);
                      //             _scrollToTop();
                      //           } else {
                      //             Get.snackbar('Error', 'Invalid product data', duration: Duration(seconds: 1));
                      //           }
                      //         },
                      //         child: Row(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Container(
                      //               height: 80,
                      //               width: 80,
                      //               decoration: BoxDecoration(
                      //                 color: TColors.colorprimaryLight.withOpacity(.10),
                      //                 borderRadius: BorderRadius.circular(15),
                      //                 border: Border.all(
                      //                   color: TColors.colorlightgrey,
                      //                 ),
                      //               ),
                      //               child: ClipRRect(
                      //                 borderRadius: BorderRadius.circular(15),
                      //                 child:  Center(
                      //                   child: product.imageUrl != null && product.imageUrl!.isNotEmpty
                      //                       ? CachedNetworkImage(
                      //                     imageUrl: product.imageUrl!,
                      //                     placeholder: (context, url) => Center(
                      //                       child: Padding(
                      //                         padding: const EdgeInsets.all(20.0),
                      //                         child: CircularProgressIndicator(),
                      //                       ),
                      //                     ),
                      //                     errorWidget: (context, url, error) => Center(child: Image.asset("assets/images/no-item-found.png")),
                      //                     fit: BoxFit.cover,
                      //                   )
                      //                       : Image.asset("assets/images/no-item-found.png"),
                      //                 ),
                      //               ),
                      //             ),
                      //
                      //
                      //             SizedBox(width: 8), // Adjusted width for better spacing
                      //             Expanded(
                      //               child: Column(
                      //                 mainAxisAlignment: MainAxisAlignment.center,
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(
                      //                       product.title!,
                      //                       style: AppTextStyles.textHeadingTitle.copyWith(fontSize: 15,
                      //                           fontWeight: FontWeight.w600,
                      //                           overflow: TextOverflow.ellipsis,color: colorsecondary)
                      //                   ),
                      //                   Text(
                      //                     product.subtitle!,
                      //                     style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w400,fontSize: 11,color: TColors.colorlightgrey),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //             SizedBox(width: 8),
                      //             Align(
                      //               alignment: Alignment.topRight,
                      //               child: Text(
                      //                 product.price!,
                      //                 style: AppTextStyles.textHeadingTitle.copyWith(fontWeight: FontWeight.w600,color: TColors.colorprimaryLight,fontSize: 15),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),

                      ///////////

                      SizedBox(
                        height: 200,
                        child: ListView.separated(
                          itemCount: controller.productsClam.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final product = controller.productsClam[index];
                            String fullImageUrl = ApiService.imageUrl;
                            String imageUrl = '';
                            if (index < controller.images.length) {
                              imageUrl = controller.images[index];
                            }
                            if (imageUrl.isNotEmpty && !imageUrl.contains('default_image.jpg')) {
                              imageUrl = '$fullImageUrl$imageUrl';
                            } else {
                              imageUrl = 'assets/images/default_image.jpg'; // Fallback image
                            }
                            return GestureDetector(
                              onTap: () {
                                print("dsgdsg${product.id }${product.kategorie1}");
                                if (product.id != null && product.kategorie1 != null) {
                                  controller.getDetailPageApi(product.id!, product.kategorie1!);
                                  _scrollToTop();
                                } else {
                                  Get.snackbar('Error', 'Invalid product data', duration: const Duration(seconds: 1));
                                }
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: TColors.colorprimaryLight.withOpacity(.10),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: TColors.colorlightgrey,
                                      ),
                                    ),
                                    child:ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child:  Center(
                                        child: product.imageUrl != null && product.imageUrl!.isNotEmpty
                                            ? CachedNetworkImage(
                                          imageUrl: product.image!,
                                          placeholder: (context, url) => const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(20.0),
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
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.title!,
                                          style: AppTextStyles.textHeadingTitle.copyWith(fontSize: 15, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis, color: colorsecondary),
                                        ),
                                        Text(
                                          product.subtitle!,
                                          style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w400, fontSize: 11, color: TColors.colorlightgrey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      product.price!,
                                      style: AppTextStyles.textHeadingTitle.copyWith(fontWeight: FontWeight.w600, color: TColors.colorprimaryLight, fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),




                      if(controller.relateProducts.isNotEmpty)
                      const SizedBox(height: 20),
                      if(controller.relateProducts.isNotEmpty)
                      Row(
                        children: [
                          Text(
                              "Related Products",
                              style: AppTextStyles.black20.copyWith(fontSize: 20,
                                  fontWeight: FontWeight.w600,color: colorsecondary)
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            "assets/images/button_SeeAll.svg",
                          ),
                        ],
                      ),
                      if(controller.relateProducts.isNotEmpty)
                      const SizedBox(height: 20),
                      if(controller.relateProducts.isNotEmpty)
                      // Container(height: 220,
                      //   child: GridView.builder(
                      //     shrinkWrap: true,
                      //     physics: NeverScrollableScrollPhysics(),
                      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 2,
                      //       crossAxisSpacing: 10,
                      //       mainAxisSpacing: 10,
                      //       childAspectRatio: 0.8,
                      //     ),
                      //     itemCount: controller.relateProducts.length,
                      //     itemBuilder: (context, index) {
                      //       final product = controller.relateProducts[index];
                      //       String fullImageUrl = ApiService.imageUrl;
                      //       String imageUrl = controller.images[index];
                      //       if (imageUrl.isNotEmpty && !imageUrl.contains('default_image.jpg')) {
                      //         imageUrl = '$fullImageUrl$imageUrl';
                      //       } else {
                      //         imageUrl = 'assets/images/default_image.jpg'; // Fallback image
                      //       }
                      //       return Container(
                      //         decoration: BoxDecoration(
                      //           color: TColors.colorprimaryLight.withOpacity(.10),
                      //           borderRadius: BorderRadius.circular(15),
                      //           border: Border.all(
                      //             color: TColors.colorlightgrey, // Replace AppColors.CommanGrey
                      //           ),
                      //         ),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Expanded(
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.circular(15),
                      //                   ),
                      //                   child: CachedNetworkImage(
                      //                     imageUrl: imageUrl,
                      //                     placeholder: (context, url) => Center(
                      //                       child: Padding(
                      //                         padding: const EdgeInsets.all(20.0),
                      //                         child: CircularProgressIndicator(),
                      //                       ),
                      //                     ),
                      //                      errorWidget: (context, url, error) => Center(child: Image.asset("assets/images/no-item-found.png")),
                      //                     fit: BoxFit.cover,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child: Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(product.name!, style: AppTextStyles.textTitleLight.copyWith(color: TColors.colorlightgrey)), // Customize text style as needed
                      //                   SizedBox(height: 4),
                      //                   Row(
                      //                     children: [
                      //                       Text("⭐️", style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w700,color: TColors.colorlightgrey)),
                      //                       Text( "${product.rating}", style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w700,fontSize: 15),),
                      //                       Text(product.point!, style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w700,color: TColors.colorlightgrey,fontSize: 13)),
                      //
                      //                     ],
                      //                   ),
                      //                   SizedBox(height: 4),
                      //                   Row(
                      //                     children: [
                      //                       Text(product.price!, style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w700,fontSize: 15),),
                      //                       Spacer(),
                      //                       InkWell(onTap: () {
                      //                         print("Add to card");
                      //                         controller.addToCartApi("${product.id}");
                      //                       },
                      //                         child: SvgPicture.asset(
                      //                           TImages.iconplus,
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //
                      //                 ],
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),

                        // Container(
                        //   height: 220,
                        //   child: Obx(() {
                        //     if (controller.relateProducts.isEmpty) {
                        //       return Center(
                        //         child: Text(
                        //           'No Releted Product',
                        //           style: TextStyle(fontSize: 16, color: Colors.black54),
                        //         ),
                        //       );
                        //     } else {
                        //       return Row(
                        //         children: List.generate(
                        //           2,
                        //               (index) {
                        //             if (index >= controller.relateProducts.length) {
                        //               // Check if index is valid
                        //               return Expanded(
                        //                 child: Center(child: Text('Invalid item index')),
                        //               );
                        //             }
                        //
                        //             final product = controller.relateProducts[index];
                        //             String fullImageUrl = ApiService.imageUrl;
                        //             String imageUrl = controller.images[index];
                        //             if (imageUrl.isNotEmpty && !imageUrl.contains('default_image.jpg')) {
                        //               imageUrl = '$fullImageUrl$imageUrl';
                        //             } else {
                        //               imageUrl = 'assets/images/default_image.jpg'; // Fallback image
                        //             }
                        //
                        //             return Expanded(
                        //               child: GestureDetector(
                        //                 onTap: (){
                        //                   print("dsgdsg${product.id }${product.kategorie1}");
                        //                   controller.getDetailPageApi(product.id!, product.kategorie1!);
                        //                   _scrollToTop();
                        //                 },
                        //                 child: Container(
                        //                   margin: EdgeInsets.all(5),
                        //                   decoration: BoxDecoration(
                        //                     color: TColors.colorprimaryLight.withOpacity(.10),
                        //                     borderRadius: BorderRadius.circular(15),
                        //                     border: Border.all(
                        //                       color: TColors.colorlightgrey, // Replace AppColors.CommanGrey
                        //                     ),
                        //                   ),
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.all(6.0),
                        //                     child: Column(
                        //                       crossAxisAlignment: CrossAxisAlignment.start,
                        //                       children: [
                        //                         Center(
                        //                           child: Container(
                        //                             width: 90,
                        //                             height: 90,
                        //                             decoration: BoxDecoration(
                        //                               borderRadius: BorderRadius.circular(15),
                        //                             ),
                        //                             child:  Center(
                        //                               child: product.imageUrl != null && product.imageUrl!.isNotEmpty
                        //                                   ? CachedNetworkImage(
                        //                                 imageUrl: product.imageUrl!,
                        //                                 placeholder: (context, url) => Center(
                        //                                   child: Padding(
                        //                                     padding: const EdgeInsets.all(20.0),
                        //                                     child: CircularProgressIndicator(),
                        //                                   ),
                        //                                 ),
                        //                                 errorWidget: (context, url, error) => Center(child: Image.asset("assets/images/no-item-found.png")),
                        //                                 fit: BoxFit.cover,
                        //                               )
                        //                                   : Image.asset("assets/images/no-item-found.png"),
                        //                             ),
                        //                           ),
                        //                         ),
                        //                         SizedBox(height: 5,),
                        //                         Column(
                        //                           crossAxisAlignment: CrossAxisAlignment.start,
                        //                           children: [
                        //                             Text(
                        //                               product.name!,
                        //                               style: AppTextStyles.textTitleLight.copyWith(color: TColors.colorlightgrey),maxLines: 2,overflow: TextOverflow.ellipsis,
                        //                             ),
                        //                             SizedBox(height: 4),
                        //                             Row(
                        //                               children: [
                        //                                 Text("⭐️", style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w700, color: TColors.colorlightgrey)),
                        //                                 Text(
                        //                                   "${product.rating}",
                        //                                   style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w700, fontSize: 15, color: colorsecondary),
                        //                                 ),
                        //                                 Text(
                        //                                   "(${product.review})",
                        //                                   style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w700, color: TColors.colorlightgrey, fontSize: 15),
                        //                                 ), ],
                        //                             ),
                        //                             SizedBox(height: 4),
                        //                             Row(
                        //                               children: [
                        //                                 Text("${product.price!}€", style: AppTextStyles.textTitleMedium.copyWith(fontWeight: FontWeight.w700, fontSize: 15)),
                        //                                 Spacer(),
                        //                                 InkWell(
                        //                                   onTap: () {
                        //                                     print("Add to cart");
                        //                                     controller.addToCartRelatedApi("${product.id}");
                        //                                   },
                        //                                   child: SvgPicture.asset(
                        //                                     TImages.iconplus,
                        //                                   ),
                        //                                 ),
                        //                               ],
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             );
                        //           },
                        //         ),
                        //       );
                        //     }
                        //   }),
                        // )

                        SizedBox(
                          height: 220,
                          child: Obx(() {
                            if (controller.relateProducts.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No Related Product',
                                  style: TextStyle(fontSize: 16, color: Colors.black54),
                                ),
                              );
                            } else {
                              // Determine the number of products to display, either 1 or 2
                              int itemCount = controller.relateProducts.length < 2 ? controller.relateProducts.length : 2;

                              return Row(
                                children: List.generate(
                                  itemCount, // Only generate as many items as available (up to 2)
                                      (index) {
                                    final product = controller.relateProducts[index];

                                    String fullImageUrl = ApiService.imageUrl;
                                    String imageUrl = controller.images.length > index ? controller.images[index] : '';

                                    if (imageUrl.isNotEmpty && !imageUrl.contains('default_image.jpg')) {
                                      imageUrl = '$fullImageUrl$imageUrl';
                                    } else {
                                      imageUrl = 'assets/images/default_image.jpg'; // Fallback image
                                    }

                                    return Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          print("Product ID: ${product.id}, Category: ${product.kategorie1}");
                                          controller.getDetailPageApi(product.id!, product.kategorie1!);
                                          _scrollToTop();
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: TColors.colorprimaryLight.withOpacity(.10),
                                            borderRadius: BorderRadius.circular(15),
                                            border: Border.all(
                                              color: TColors.colorlightgrey, // Replace AppColors.CommanGrey
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    width: 90,
                                                    height: 90,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    child: Center(
                                                      child: product.imageUrl != null && product.imageUrl!.isNotEmpty
                                                          ? CachedNetworkImage(
                                                        imageUrl: product.image!,
                                                        placeholder: (context, url) => const Center(
                                                          child: Padding(
                                                            padding: EdgeInsets.all(20.0),
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
                                                const SizedBox(height: 5),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      product.name!,
                                                      style: AppTextStyles.textTitleLight.copyWith(color: TColors.colorlightgrey),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Row(
                                                      children: [
                                                        Text("⭐️",
                                                            style: AppTextStyles.textTitleMedium.copyWith(
                                                                fontWeight: FontWeight.w700,
                                                                color: TColors.colorlightgrey)),
                                                        Text(
                                                          "${product.rating}",
                                                          style: AppTextStyles.textTitleMedium.copyWith(
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: 15,
                                                              color: colorsecondary),
                                                        ),
                                                        Text(
                                                          "(${product.review})",
                                                          style: AppTextStyles.textTitleMedium.copyWith(
                                                              fontWeight: FontWeight.w700,
                                                              color: TColors.colorlightgrey,
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Row(
                                                      children: [
                                                        Text("${product.price!}€",
                                                            style: AppTextStyles.textTitleMedium.copyWith(
                                                                fontWeight: FontWeight.w700,
                                                                color: TColors.colorprimaryDark,                                                                fontSize: 15)),
                                                        const Spacer(),
                                                        InkWell(
                                                          onTap: () {
                                                            print("Add to cart");
                                                            controller.addToCartRelatedApi("${product.id}");
                                                          },
                                                          child: SvgPicture.asset(
                                                            TImages.iconplus,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          }),
                        )



                    ],
                  ),
                ),
              ),
          Center(child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
          child:  ShowLoader.isLoadingProgress(controller.isLoading.value),
          )),
            ],
          );
        }),
        ),
    );
  }
}
///   bacground in search