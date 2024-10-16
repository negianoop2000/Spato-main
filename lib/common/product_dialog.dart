// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:spato/utils/constants/app_text_styles.dart';
// import 'package:spato/utils/constants/colors.dart';
// import 'package:spato/utils/constants/common_app_buttons.dart';
// import 'package:spato/utils/constants/image_strings.dart';
// import 'package:spato/utils/constants/sizes.dart';
//
//
//
// class ProductDialog extends StatelessWidget {
//
//   const ProductDialog({
//     super.key,
//
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     Color colorsecondary = Theme.of(context).brightness == Brightness.light
//         ? TColors.colorsecondaryLight
//         : TColors.colorsecondaryDark;
//     Color background = Theme.of(context).brightness == Brightness.light
//         ? TColors.containerFillDark
//         : TColors.black;
//     Color borderColor = Theme.of(context).brightness == Brightness.light
//         ? TColors.colorlightgrey
//         : TColors.darkerGrey;
//     double screenHeight = AppConstants.getScreenHeight(context);
//     double screenWidth = AppConstants.getScreenWidth(context);
//     return Dialog(
//       elevation: 0,
//       backgroundColor: background,
//       child: Container(
//         width: kIsWeb ? 200 : 400, // Adjusted for web width
//         child: Stack(
//           fit: StackFit.loose,
//           alignment: Alignment.topCenter,
//           children: [
//             SizedBox(
//               child: Container(
//                 margin: const EdgeInsets.only(top: 20),
//                 padding: const EdgeInsets.only(
//                     top: 0, left: 0, right: 0, bottom: 0),
//                 decoration: BoxDecoration(
//                   color: background,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.transparent),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Center(
//                       child: Image.asset(
//                         TImages.icondummyprod,
//                         height: 180,
//                         width: 150,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: Text(
//                         "Fairland X-Warrior X60",
//                         style: AppTextStyles.textHeadingTitle.copyWith(
//                             fontSize: 24, fontWeight: FontWeight.w600,color: colorsecondary),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           top: 8, bottom: 0, left: 8, right: 8),
//                       child: Text(
//                         "€415.88",
//                         style: AppTextStyles.textHeadingTitle.copyWith(
//                             fontSize: 20, fontWeight: FontWeight.w600,color: colorsecondary),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           top: 8, bottom: 0, left: 8, right: 8),
//                       child: Text(
//                         "Product code - 2104060038",
//                         style: AppTextStyles.textTitleMedium.copyWith(
//                             fontSize: 15, fontWeight: FontWeight.w500,color: TColors.colorlightgrey),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           top: 8, bottom: 0, left: 8, right: 8),
//                       child: Text(
//                         "Manufacturer - SPECK",
//                         style: AppTextStyles.textTitleMedium.copyWith(
//                             fontSize: 15, fontWeight: FontWeight.w500,color: TColors.colorlightgrey),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           top: 8, bottom: 0, left: 8, right: 8),
//                       child: CommonAppButton(
//                         width: double.infinity,
//                         color: TColors.colorprimaryLight,
//                         height: 45,
//
//                         onPressed: () {
//                           // Handle button press
//                           Navigator.pop(context);
//                         },
//                         buttonText: "View Card",
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           top: 0, bottom: 20, left: 8, right: 8),
//                       child: TextButton(
//                         onPressed: () {
//                           // Handle button press
//                           Navigator.pop(context);
//                         },
//                         child: Text(
//                           "Continue Shopping",
//                           style: AppTextStyles.textTitleMedium
//                               .copyWith(fontWeight: FontWeight.w600,color: colorsecondary,fontSize: 17),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
