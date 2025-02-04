import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/app/modules/introVC/controllers/intro_v_c_controller.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';


class IntroVCView extends StatelessWidget {
  final IntroVCController controller = Get.put(IntroVCController());

  @override
  Widget build(BuildContext context) {
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    String imagePath = Theme.of(context).brightness == Brightness.light
        ? "assets/logos/SPATO-TextLogo-lifgt.png"
        : "assets/logos/SPATO-TextLogo-dark.png";
    String startImage = Theme.of(context).brightness == Brightness.light
        ? 'assets/images/start_container_lightMode.png'
        : 'assets/images/start_container.png';
    Color screenColor = Theme.of(context).brightness == Brightness.light
        ? Color(0xfff9f9ff)
        : Color(0xff1e1e1e);




    return Scaffold(
      backgroundColor: screenColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Center(
              child:Image.asset(imagePath),
            ),
            // SizedBox(height: 20),
            // Center(
            //   child: Image.asset(
            //     TImages.imgSpatoicon,
            //     height: 250,width: 200,
            //   ),
            // ),
            SizedBox(height: 100),
            Text(
              TTexts.txtIntrostartJaurney,
              style: AppTextStyles.textHeadingTitle.copyWith(color: colorsecondary),textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              TTexts.txtIntrofindall,
              style: AppTextStyles.textTitle.copyWith(color: colorsecondary,fontSize: 15),textAlign: TextAlign.center,
            ),
            Spacer(),
            InkWell(
              onTap: () {
              Get.toNamed(Routes.LOGIN);
              },
              child:  Container(
                width: 212,
                height: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                    image: DecorationImage(image: AssetImage(startImage),fit: BoxFit.cover)
                ),
                child: Center(child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(TTexts.txtIntroStart, style: AppTextStyles.textTitleMedium,),
                      Icon(Icons.arrow_forward,color: TColors.black,size: 20,)
                    ],
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
