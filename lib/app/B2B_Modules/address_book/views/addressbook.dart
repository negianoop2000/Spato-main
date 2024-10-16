import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spato_mobile_app/app/B2B_Modules/address_book/controllers/addressbook.dart';
import 'package:spato_mobile_app/app/B2B_Modules/address_book/views/add_addressbook.dart';
import 'package:spato_mobile_app/app/B2B_Modules/drawer_b2b.dart';
import 'package:spato_mobile_app/common/bottomNavigationTap.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/common/common_app_buttons.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/common_input_fields.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';




class AddressbookB2BView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddressbookB2BController controller = Get.find<AddressbookB2BController>();
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
          "Address list",
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
                border: Border.all(
                  color: borderColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.arrow_back_ios, color: colorsecondary, size: 15),
              ),
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              await Get.to(() => Add_addressBookView());
              controller.addressListFetched();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.add, color: colorsecondary, size: 35),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
                      child:  ShowLoader.isLoadingProgress(controller.isLoading.value),
                    ));
                  } else if (controller.addresses.isEmpty) {
                    return Center(child: Text('No addresses available.'));
                  } else {
                    return ListView.separated(
                      itemCount: controller.addresses.length,
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final address = controller.addresses[index];
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: background,
                            border: Border.all(
                              color: borderColor,
                            ),
                          ),
                          child: ListTile(
                            onTap: () => controller.selectAddress(address['id']),
                            title: Text(
                              address['formattedAddress'],
                              style: TextStyle(
                                fontWeight: controller.selectedAddressId.value == address['id']
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () => controller.deleteAddressApi(address['id']),
                              icon: Icon(Icons.delete, color: Colors.red),
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


