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
  ProfileScreenView({super.key});



  @override
  Widget build(BuildContext context) {
    final ProfileScreenController controller = Get.find<ProfileScreenController>(tag: 'profile');
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

    Color iconselected = Theme.of(context).brightness == Brightness.light
        ? TColors.colorprimaryLight
        : TColors.white;
    Color iconUnselected = Theme.of(context).brightness == Brightness.light
        ? TColors.colordarkgrey
        : TColors.colorprimaryLight;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: AppTextStyles.black20.copyWith(color: colorsecondary)),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
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
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: ClipOval(
                              child: Obx(
                                    () => CachedNetworkImage(
                                  imageUrl: "$fullImageUrl${controller.userImage.value}",
                                  placeholder: (context, url) => Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
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
                      ),
                      SizedBox(height: 8),
                      Obx(() => Text(controller.userName.value, style: AppTextStyles.black20.copyWith(color: colorsecondary))),
                      Obx(() => Text(controller.userEmail.value, style: AppTextStyles.grey14)),
                      SizedBox(height: 8),
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
                      SizedBox(height: 20),
                      Default_Coustom(
                        onTap: () {
                          Get.toNamed(Routes.MY_ORDER_SCREEN);
                        },
                        svgImage: TImages.imgMyOrder,
                        text: 'My Order',
                      ),
                      // Default_Coustom(
                      //   onTap: () {
                      //     Get.toNamed(Routes.GENERAL_SETTING);
                      //   },
                      //   svgImage: TImages.imggeneral,
                      //   text: 'General Setting',
                      // ),
                      Visibility(
                        visible: controller.role.value == "b2b",
                        child: Default_Coustom(
                          onTap: () {
                            Get.toNamed(Routes.DASHBORD_B2B);
                          },
                          svgImage: TImages.imggeneral,
                          text: 'B2B dashboard',
                        ),
                      ),
                      Visibility(
                        visible: controller.role.value == "Normal",
                        child: Default_Coustom(
                          onTap: () {
                            Get.toNamed(Routes.OFFER_ROLE_SCREEN);
                          },
                          svgImage: TImages.imggeneral,
                          text: 'Offer',
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
                      Logout_Coustom(
                        onTap: () {
                         //Get.offNamed(Routes.LOGIN);
                         controller.logoutUser();
                        },
                        svgImage: TImages.imgLogout,
                        text: 'Logout',
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Get.dialog(
                      //       AlertDialog(
                      //         title: Text('Confirm Delete', style: AppTextStyles.black16.copyWith(color: colorsecondary,fontSize: 18)),
                      //         content: Text('Are you sure you want to delete your account?', style: AppTextStyles.black14.copyWith(color: colorsecondary)),
                      //         actions: [
                      //           TextButton(
                      //             onPressed: () {
                      //               Get.back(); // Close the dialog
                      //             },
                      //             child: Text('Cancel', style: AppTextStyles.black20.copyWith(color: colorsecondary,fontSize: 18)),
                      //           ),
                      //           TextButton(
                      //             onPressed: () {
                      //               Get.back(); // Close the dialog
                      //               controller.deleteUser(); // Call deleteUser
                      //             },
                      //             child: Text('OK', style: AppTextStyles.black20.copyWith(color: colorsecondary,fontSize: 18)),
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(bottom: 15),
                      //     child: Container(
                      //       width: double.infinity,
                      //       decoration: BoxDecoration(
                      //         color: background,
                      //         borderRadius: BorderRadius.circular(15),
                      //         border: Border.all(
                      //           color: borderColor,
                      //         ),
                      //       ),
                      //       child: ListTile(
                      //         leading: Image.asset(
                      //           "assets/images/delete-user.png",
                      //           color: Colors.red,
                      //           height: 30,
                      //           width: 30,
                      //         ),
                      //         title: Text(
                      //           "Delete account",
                      //           style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.w500).copyWith(color: TColors.textRed),
                      //         ),
                      //         trailing: SvgPicture.asset(TImages.lightArrowForward, color: TColors.textRed), // Arrow icon
                      //       ),
                      //     ),
                      //   ),
                      // ),


                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
                child:  ShowLoader.isLoadingProgress(controller.isLoading.value),
              )
            ],
          ),
        ),
      ),
    );
  }
}
