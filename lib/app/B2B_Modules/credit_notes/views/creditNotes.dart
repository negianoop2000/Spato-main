import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/app/B2B_Modules/credit_notes/controllers/creditNotes.dart';
import 'package:spato_mobile_app/app/B2B_Modules/drawer_b2b.dart';
import 'package:spato_mobile_app/common/bottomNavigationTap.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';




class creditNotesB2BView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final creditNotesB2BController controller = Get.find<creditNotesB2BController>();
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.containerFill
        : TColors.black;
    Color background2 = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;

    return Scaffold(
     // drawer: Drawer_B2B(),
      appBar: AppBar(
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
        title: Obx(() => Text(
          controller.title.value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: colorsecondary,
          ),
        )),
        // actions: [
        //   TextButton(onPressed: (){
        //     Get.offAll(() => BottomNavigationTap(initialIndex: 3));},
        //     child: Text("Back",style: AppTextStyles.black14.copyWith(fontWeight: FontWeight.w600, color: colorsecondary)),
        //   ),],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextInputField(
              height: 50,
              borderColor: borderColor,
              backgroundColor: background,
              hintText: "Search",
              hintStyle: TextStyle(color: TColors.colorlightgrey),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              onChange: controller.updateSearchQuery,
              onTap: () {},
              prefixIcon: Icon(Icons.search),
            ),
          SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 50,
                    child: Text(
                      'Status',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: colorsecondary),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 50,
                    child: Text(
                      'Credit No',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: colorsecondary),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 50,
                    child: Text(
                      'Net Amount',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: colorsecondary),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0), // Add some space between header and list
            Divider(
              color: Colors.grey,
              height: 1.0,
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
                    child: ShowLoader.isLoadingProgress(controller.isLoading.value),
                  );
                }

                if (controller.filteredOrders.isEmpty) {
                  return Center(child: Text('No offer data found'));
                }

                return ListView.separated(
                  itemCount: controller.filteredOrders.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                    height: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    final order = controller.filteredOrders[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              order['status'] ?? '',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colorsecondary),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              order['Gutschrifts_Nr'] ?? '',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colorsecondary),
                            ),
                          ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          order['Ihre_Kundennummer'] ?? '',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colorsecondary),
                        ),
                      ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}