import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:spato_mobile_app/app/data/model/detail_data_model.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';

import '../../../../common/common_app_buttons.dart';
import '../controllers/spare_part_screen_controller.dart';

class SparePartScreenView extends StatelessWidget {
  final SparePartScreenController controller = Get.put(SparePartScreenController());
  final GlobalKey _imageKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    final List<SparePart> spareParts = Get.arguments['spareParts'];

    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey.withOpacity(0.1)
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
   print("fgrdfg");


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Spare Parts",
            style: AppTextStyles.black20.copyWith(fontWeight: FontWeight.w600, color: colorsecondary),
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
                  border: Border.all(color: borderColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(Icons.arrow_back_ios, color: colorsecondary, size: 15),
                ),
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(() {

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (controller.verticalScrollController.hasClients && controller.horizontalScrollController.hasClients) {
              double verticalOffset = (controller.verticalScrollController.position.maxScrollExtent / 2);
              double horizontalOffset = (controller.horizontalScrollController.position.maxScrollExtent / 2);
              print("$verticalOffset ------- $horizontalOffset");
              controller.verticalScrollController.jumpTo(verticalOffset);
              controller.horizontalScrollController.jumpTo(horizontalOffset);
            }
          });

          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width + 80,
                  child: ListView.builder(
                    itemCount: spareParts.length,
                    itemBuilder: (context, index) {
                      final sparePart = spareParts[index];
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${sparePart.articleName}",
                              style: AppTextStyles.black16.copyWith(fontWeight: FontWeight.w600, color: colorsecondary),
                            ),
                            SizedBox(height: 12),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width, // Ensure square aspect
                              child: Scrollbar(
                                controller: controller.verticalScrollController,
                                trackVisibility: true,
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  controller: controller.verticalScrollController,
                                  scrollDirection: Axis.vertical,
                                  child: Container(
                                    width: 2400,
                                    height: 2400,
                                    child: Scrollbar(
                                      controller: controller.horizontalScrollController,
                                      trackVisibility: true,
                                      thumbVisibility: true,
                                      child: SingleChildScrollView(
                                        controller: controller.horizontalScrollController,
                                        scrollDirection: Axis.horizontal,
                                        child: GestureDetector(
                                            key: _imageKey,
                                            onTapUp: (details) {
                                              final RenderBox renderBox = _imageKey.currentContext!.findRenderObject() as RenderBox;
                                              double adjustedX = details.localPosition.dx * (2400 / renderBox.size.width);
                                              double adjustedY = details.localPosition.dy * (2400 / renderBox.size.width);
                                              controller.extractText_sparePart(adjustedX.toString(), adjustedY.toString(), sparePart.productId.toString());

                                              // Update the tap position
                                              controller.tapPosition.value = Offset(adjustedX, adjustedY);
                                              controller.AllTapPosition.add(Offset(adjustedX, adjustedY));

                                              //  getnumbers(sparePart);
                                            },
                                            child: Stack(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: "https://spa2.de/storage/spare_part/images/${sparePart.articleImage}",
                                                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                  errorWidget: (context, url, error) => Center(child: Image.asset("assets/images/no-item-found.png")),
                                                  fit: BoxFit.cover,
                                                ),
                                                Obx(() {
                                                  return Container(
                                                    width: 2400,
                                                    height: 2400,
                                                    child: Stack(
                                                      children: controller.AllTapPosition.map((position) {
                                                        return Positioned(
                                                          left: position.dx,
                                                          top: position.dy,
                                                          child: Container(
                                                            width: 20,
                                                            height: 20,
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: TColors.colorprimaryLight,
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  );
                                                }),
                                              ],
                                            )

                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          SizedBox(height: 12),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(width: double.infinity,
                  height: MediaQuery.of(context).size.width,
                  child: Obx(() {
                    return controller.inputSparPartList.isEmpty
                        ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                          children: [
                    Divider(color: Colors.grey, height: 1.0),
                    SizedBox(height: 8.0),
                            Center(child: Text('No spare parts added for buy. For add please tap on the image drawing number to add spare parts.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colorsecondary),textAlign: TextAlign.center,))]),

                    )
                        : Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                                          children: [
                          Row(
                            children: [
                              Expanded(flex: 1, child: Center(child: Text('Drawing\nNo.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colorsecondary),textAlign: TextAlign.center,))),
                              Expanded(flex: 3, child: Center(child: Text('Description\n ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colorsecondary)))),
                              Expanded(flex: 1, child: Center(child: Text('Price\n', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colorsecondary)))),
                              Expanded(flex: 1, child: Center(child: Text('', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colorsecondary)))),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Divider(color: Colors.grey, height: 1.0),
                          SizedBox(height: 8.0),
                                            Expanded(
                                              child: ListView.separated(
                                                shrinkWrap: true,
                                                itemCount: controller.inputSparPartList.length,
                                                separatorBuilder: (context, index) => Divider(color: Colors.grey, height: 1.0),
                                                itemBuilder: (context, index) {
                                                  final sparePart = controller.inputSparPartList[index];
                                                  return Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Center(
                                                          child: Text(
                                                            sparePart.partNo ?? '',  // Handle null values safely
                                                            style: AppTextStyles.black12.copyWith(color: colorsecondary),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Center(
                                                          child: Text(
                                                            sparePart.beschreibung ?? '',  // Handle null values safely
                                                            style: AppTextStyles.black12.copyWith(color: colorsecondary),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Center(
                                                          child: Text(
                                                            '${sparePart.rate?? ''}€',  // Handle null finalRate safely
                                                            style: AppTextStyles.black12.copyWith(color: colorsecondary, fontWeight: FontWeight.w600),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Center(
                                                          child: IconButton(
                                                            icon: Icon(Icons.delete, color: Colors.red),
                                                            onPressed: () {
                                                              controller.deleteSparePart(index);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),

                                          ],
                                        ),
                        );
                  }),
                ),
              ],
            ),
          );
        }),
        bottomNavigationBar: Obx(() {
          return Container(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10,top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Total Price: ${controller.totalPrice.value.toStringAsFixed(2)}€',
                      style: AppTextStyles.black16.copyWith(fontWeight: FontWeight.w600, color: colorsecondary),
                    ),
                  ),
                  Expanded(
                    child: CommonAppButton(
                      color: TColors.colorprimaryLight,
                      onPressed: () {
                        controller.buy_SpareParts();
                      },
                      buttonText: "Buy SpareParts",
                      btnTextStyle: AppTextStyles.black20.copyWith(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}



// Container(
//                               width: MediaQuery.of(context).size.width,
//                               height: MediaQuery.of(context).size.width, // Ensure square aspect
//                               child: Stack(
//                                 children: [
//                                   Obx(() {
//                                     if (controller.tapPosition.value != null) {
//                                       return Positioned(
//                                         left: controller.tapPosition.value!.dx - 10,
//                                         top: controller.tapPosition.value!.dy - 10,
//                                         child: Container(
//                                           width: 100,
//                                           height: 100,
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       );
//                                     }
//                                     return SizedBox.shrink();
//                                   }),
//                                   Scrollbar(
//                                     controller: controller.verticalScrollController,
//                                     trackVisibility: true,
//                                     thumbVisibility: true,
//                                     child: SingleChildScrollView(
//                                       controller: controller.verticalScrollController,
//                                       scrollDirection: Axis.vertical,
//                                       child: Container(
//                                         width: 1300,
//                                         height: 1300,
//                                         child: Scrollbar(
//                                           controller: controller.horizontalScrollController,
//                                           trackVisibility: true,
//                                           thumbVisibility: true,
//                                           child: SingleChildScrollView(
//                                             controller: controller.horizontalScrollController,
//                                             scrollDirection: Axis.horizontal,
//                                             child: GestureDetector(
//                                               key: _imageKey,
//                                               onTapUp: (details) {
//                                                 final RenderBox renderBox = _imageKey.currentContext!.findRenderObject() as RenderBox;
//                                                 double adjustedX = details.localPosition.dx * (1300 / renderBox.size.width);
//                                                 double adjustedY = details.localPosition.dy * (1300 / renderBox.size.width);
//                                                 controller.extractText_sparePart(adjustedX.toString(), adjustedY.toString(), sparePart.productId.toString());
//
//                                                 // Update the tap position
//                                                 controller.tapPosition.value = Offset(adjustedX, adjustedY);
//                                                 print("sdbbdsdsba");
//                                                 print(controller.tapPosition.value );
//                                               },
//                                               child: CachedNetworkImage(
//                                                 imageUrl: "https://spa2.de/storage/spare_part/images/${sparePart.articleImage}",
//                                                 placeholder: (context, url) => Center(child: CircularProgressIndicator()),
//                                                 errorWidget: (context, url, error) => Center(child: Image.asset("assets/images/no-item-found.png")),
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//
//                                 ],
//                               ),
//                             ),



//   Container(
//   width:  MediaQuery.of(context).size.width,
//   height: MediaQuery.of(context).size.width, // Ensure square aspect
//   child: Scrollbar(
//     controller: controller.verticalScrollController,
//     trackVisibility: true,
//     thumbVisibility: true,
//     child: SingleChildScrollView(
//       controller: controller.verticalScrollController,
//       scrollDirection: Axis.vertical,
//       child: Container(
//         width: 1300,
//         height: 1300,
//         child: Scrollbar(
//           controller: controller.horizontalScrollController,
//           trackVisibility: true,
//           thumbVisibility: true,
//           child: SingleChildScrollView(
//             controller: controller.horizontalScrollController,
//             scrollDirection: Axis.horizontal,
//             child: GestureDetector(
//               key: _imageKey,
//               onTapUp: (details) {
//                 final RenderBox renderBox = _imageKey.currentContext!.findRenderObject() as RenderBox;
//                 double adjustedX = details.localPosition.dx * (1300 / renderBox.size.width);
//                 double adjustedY = details.localPosition.dy * (1300 / renderBox.size.width);
//                 controller.extractText_sparePart(adjustedX.toString(), adjustedY.toString(), sparePart.productId.toString());
//               },
//               child: CachedNetworkImage(
//                 imageUrl: "https://spa2.de/storage/spare_part/images/${sparePart.articleImage}",
//                 placeholder: (context, url) => Center(child: CircularProgressIndicator()),
//                 errorWidget: (context, url, error) => Center(child: Image.asset("assets/images/no-item-found.png")),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   ),
// ),
