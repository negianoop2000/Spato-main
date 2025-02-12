import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/common/common_app_buttons.dart';
import 'package:spato_mobile_app/common/setting_widget.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import '../controllers/profile_screen_controller.dart';

class ProfileScreenView extends StatelessWidget {
  const ProfileScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileScreenController controller =
        Get.find<ProfileScreenController>(tag: 'profile');
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.containerFill
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    String fullImageUrl = ApiService.imageUrl;
    Color textColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colordarkgrey
        : TColors.white;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: AppTextStyles.black20.copyWith(color: colorsecondary)),
        leading: const Padding(
          padding: EdgeInsets.only(left: 20),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed(Routes.SETTING);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: background,
                  border: Border.all(
                    color: borderColor,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SvgPicture.asset(TImages.imgProfilemenu),
                ),
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () => Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                            border: Border.all(
                              color: TColors.colorlightgrey,
                            ),
                          ),
                          child: ClipOval(
                            child: Obx(
                                  () {
                                String imageUrl = controller.userImage.value.isNotEmpty
                                    ? "$fullImageUrl${controller.userImage.value}"
                                    : "";
                                return CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => controller.userImage.value.isEmpty
                                      ? const SizedBox()
                                      : Center(child: Image.asset("assets/images/profile_dummy.png")),
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() => Text(controller.userName.value,
                          style: AppTextStyles.black20
                              .copyWith(color: colorsecondary))),
                      Obx(() => Text(controller.userEmail.value,
                          style: AppTextStyles.grey14)),
                      const SizedBox(height: 8),
                      CommonAppButton(
                        width: 200,
                        height: 35,
                        color: Colors.transparent,
                        borderColor: TColors.colorlightgrey,
                        onPressed: () {
                          controller.navigateToEditProfile();
                        },
                        buttonText: 'Edit Profile',
                        btnTextStyle: AppTextStyles.grey16.copyWith(color: colorsecondary),
                        borderRadius: 12,
                      ),
                      const SizedBox(height: 20),
                      Default_Coustom(
                        onTap: () {
                          Get.toNamed(Routes.MY_ORDER_SCREEN);
                        },
                        svgImage: TImages.imgMyOrder,
                        text: 'My Order',
                      ),
                      Visibility(
                        visible: controller.role.value == "b2b",
                        child: Default_Coustom(
                          onTap: () {
                            Get.toNamed(Routes.DASHBORD_B2B);
                          },
                          svgImage: TImages.imggeneral,
                         // text:AppLocalization.of(context)!.translate('b2b_dashboard'),
                          text:"B2B Dashboard"

                        ),
                      ),
                      Visibility(
                        visible: controller.role.value == "Admin",
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? TColors.colorlightgrey
                                    : TColors.darkerGrey,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.shopify_sharp),
                              title: Text(
                                "B2B Shops",
                               // AppLocalization.of(context)!.translate('b2b_shops'),
                                style: AppTextStyles.black14.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: textColor,
                                ),
                              ),
                              onTap: () async {
                                controller.getb2blist();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Choose B2B Shop'),
                                      content: Obx(
                                        () => controller.shopList.isEmpty
                                            ?  const Center(
                                                child:
                                                Text('No Shop Available'))
                                            : SizedBox(
                                                width: double.maxFinite,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: controller.shopList.length,
                                                  itemBuilder: (context, index) {
                                                    final shop = controller.shopList[index];
                                                    return ListTile(
                                                      title: Text(shop['name'] ?? 'Unknown'),
                                                      subtitle: Text(shop['b2b_shop_id'] ?? 'Unknown Shop Name'),
                                                      onTap: () {
                                                        Get.toNamed(Routes.B2B_SHOP_ADMIN_SCREEN, parameters: {'userid': shop['user_id']});
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              trailing: SvgPicture.asset(
                                TImages.lightArrowForward,
                                colorFilter: ColorFilter.mode(
                                  colorsecondary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: controller.role.value == "b2b",
                        child: Default_Coustom(
                          onTap: () async {
                            await controller.getb2blist(); // Fetch the B2B shop list

                            // Check if any shop matches the username
                            bool isShopFound = false;

                            for (var shop in controller.shopList) {
                              if (shop['name'] == controller.userName.value) {
                                isShopFound = true;
                                break;
                              }
                            }

                            if (isShopFound) {
                              // Navigate to B2B Shop Screen
                              Get.toNamed(Routes.B2B_SHOP_SCREEN);
                            } else {
                              // Show "No Shop Available" alert if no match is found
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('No Shop Available'),
                                    content: const Text('You do not have any B2B Shop matching your username.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          svgImage: TImages.imggeneral,
                          text: 'B2B Shop',
                        ),
                      ),

                      Visibility(
                        visible: controller.role.value == "Normal",
                        child: Default_Coustom(
                          onTap: () {
                            Get.toNamed(Routes.OFFER_ROLE_SCREEN);
                          },
                          svgImage: TImages.imggeneral,
                          text:'Offer',
                        ),
                      ),
                      Visibility(
                        visible: controller.role.value == "supplier",
                        child: Default_Coustom(
                          onTap: () {
                            Get.toNamed(Routes.DASHBORD_S);
                          },
                          svgImage: TImages.imggeneral,
                          text: 'Supplier Dashboard',
                        ),
                      ),



                      // Default_Coustom(
                      //   onTap: () async {
                      //     String selectedLanguage =
                      //     await LanguageHelper.getSavedLanguage(); // Load saved language
                      //
                      //     Get.dialog(
                      //       AlertDialog(
                      //         title: Text(AppLocalization.of(context)!.translate('choose_language')),
                      //         content: StatefulBuilder(
                      //           builder: (BuildContext context, StateSetter setState) {
                      //             return SizedBox(
                      //               width: double.maxFinite,
                      //               child: ListView.builder(
                      //                 shrinkWrap: true,
                      //                 itemCount: LanguageHelper.languages.length,
                      //                 itemBuilder: (context, index) {
                      //                   final language = LanguageHelper.languages[index];
                      //                   return ListTile(
                      //                     title: Text(language['name']!),
                      //                     leading: Radio<String>(
                      //                       value: language['code']!,
                      //                       groupValue: selectedLanguage,
                      //                       onChanged: (String? value) {
                      //                         if (value != null) {
                      //                           setState(() {
                      //                             selectedLanguage = value;
                      //                           });
                      //                         }
                      //                       },
                      //                     ),
                      //                     onTap: () {
                      //                       setState(() {
                      //                         selectedLanguage = language['code']!;
                      //                       });
                      //                     },
                      //                   );
                      //                 },
                      //               ),
                      //             );
                      //           },
                      //         ),
                      //         actions: [
                      //           TextButton(
                      //             onPressed: () => Get.back(),
                      //             child: Text(AppLocalization.of(context)!.translate('cancel')),
                      //           ),
                      //           TextButton(
                      //             onPressed: () async {
                      //               var localeParts = selectedLanguage.split('_');
                      //               Locale locale = Locale(
                      //                   localeParts[0], localeParts.length > 1 ? localeParts[1] : null);
                      //               await LanguageHelper.saveLanguage(selectedLanguage); // Save language
                      //               Get.updateLocale(locale);
                      //               Get.back();
                      //             },
                      //             child: Text(AppLocalization.of(context)!.translate('apply')),
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      //   svgImage: TImages.imggeneral,
                      //   text: AppLocalization.of(context)!.translate('select_language'),
                      // ),


                      Logout_Coustom(
                        onTap: () {
                          controller.logoutUser();
                        },
                        svgImage: TImages.imgLogout,
                        text: 'Logout',
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.0),
                child: ShowLoader.isLoadingProgress(controller.isLoading.value),
              )
            ],
          ),
        ),
      ),
    );
  }
}
