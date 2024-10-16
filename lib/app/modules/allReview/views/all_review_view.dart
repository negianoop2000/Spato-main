import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spato_mobile_app/app/data/model/category_productList.dart';
import 'package:spato_mobile_app/app/data/model/products_list.dart';
import 'package:spato_mobile_app/app/modules/allReview/controllers/all_review_controller.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';



class AllReviewView extends StatelessWidget {
  AllReviewView({Key? key}) : super(key: key);

  final AllReviewController controller = Get.put(AllReviewController());

  @override
  Widget build(BuildContext context) {
    // Extract arguments
    final Map<String, dynamic>? arguments = Get.arguments as Map<String, dynamic>?;
    final List<Review_List> reviews = arguments?['products'] ?? [];

    // Update controller's reviews list
    controller.reviews.value = reviews;

    // Theme colors
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
          'Reviews',
          style: AppTextStyles.black16.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: colorsecondary,
          ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Expanded(
                child: Obx(() {
                  if (controller.reviews.isEmpty) {
                    return Center(
                      child: Text(
                        'No reviews available for this product',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: controller.reviews.length,
                      itemBuilder: (context, index) {
                        final review = controller.reviews[index];
                        String fullImageUrl = ApiService.imageUrl;
                        String imageUrl = "$fullImageUrl${review.profilePicture}";
                        String formattedDate = '';
                        if (review.createdAt != null && review.createdAt!.isNotEmpty) {
                          DateTime dateTime = DateTime.parse(review.createdAt!);
                          formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
                        }
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: TColors.colorprimaryLight.withOpacity(.10),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  formattedDate, // Display the formatted date
                                  style: AppTextStyles.textTitleMedium.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: colorsecondary,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle, // Ensure circular shape
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(40), // ClipRRect with circular radius
                                        child: Center(
                                          child: review.profilePicture != null && review.profilePicture!.isNotEmpty
                                              ? CachedNetworkImage(
                                            imageUrl: imageUrl,
                                            placeholder: (context, url) => Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                            errorWidget: (context, url, error) => Center(
                                              child: Image.asset("assets/images/no-item-found.png"),
                                            ),
                                            fit: BoxFit.cover, // Ensure the image fits the container
                                          )
                                              : Image.asset("assets/images/no-item-found.png"),
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: 8),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            review.userName ?? '',
                                            style: AppTextStyles.textTitleLight.copyWith(
                                              color:colorsecondary,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "⭐️ ${review.rating ?? '0.0'}",
                                            style: AppTextStyles.textTitleMedium.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: TColors.colorlightgrey,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            review.reviewComment ?? '',
                                            style: AppTextStyles.textTitleMedium.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: colorsecondary,
                                            ),
                                            softWrap: true, // Ensure the text wraps to the next line
                                          ),
                                        ],
                                      ),
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
            ],
          ),
        ),
      ),
    );
  }
}




