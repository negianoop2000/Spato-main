import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spato_mobile_app/common/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/sizes.dart';




class DeleteDialog extends StatelessWidget {
  final VoidCallback onTap;

  const DeleteDialog({
    super.key,
    required this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = AppConstants.getScreenHeight(context);
    double screenWidth = AppConstants.getScreenWidth(context);
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: kIsWeb ? 200 : 400,
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(
                    top: 0, left: 0, right: 0, bottom: 0),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: TColors.colorlightgrey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: SvgPicture.asset(TImages.iconDelete),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 0, left: 20, right: 20),
                      child: Text(
                        "Do you want to delete this product from your cart?",
                        style: AppTextStyles.black16
                            .copyWith(fontWeight: FontWeight.w600,),maxLines: 2,textAlign: TextAlign.center,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 0, left: 8, right: 8),
                      child: CommonAppButtonWithLinearGrdiant(
                        width: double.infinity,
                        height: 45,
                        onPressed: onTap,
                        buttonText: "Delete",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 20, left: 8, right: 8),
                      child: TextButton(
                        onPressed: () {
                         Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: AppTextStyles.black16
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

