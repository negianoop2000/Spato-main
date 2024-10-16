import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import '../controllers/all_category_controller.dart';



class AllcategoryView extends StatelessWidget {
  AllcategoryView({Key? key}) : super(key: key);

  final AllcategoryController controller = Get.put(AllcategoryController());

  @override
  Widget build(BuildContext context) {
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
          "Categories",
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
            child:  ShowLoader.isLoadingProgress(controller.isLoading.value),
          ),);
        }

        if (controller.mainCategories.isEmpty) {
          return Center(child: Text('No categories available'));
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemCount: controller.mainCategories.length,
            separatorBuilder: (context, index) => SizedBox(height: 12),
            itemBuilder: (context, index) {
              var mainCategory = controller.mainCategories[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('selectedMainCategoryName', mainCategory.name);
                      print("=============446645456564654--------+++++++++++++ ${mainCategory.name}");
                      controller.selectMainCategory(mainCategory);
                    },
                    child: Card(
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            mainCategory.imagePath ?? 'assets/images/no-item-found.png',
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          mainCategory.name,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.arrow_drop_down_outlined),
                      ),
                    ),
                  ),
                  Obx(() {
                    if (controller.selectedMainCategory.value == mainCategory) {
                      if (controller.subCategories.isEmpty) {
                        return Center(child: Text('No subcategories available'));
                      }

                      return Column(
                        children: controller.subCategories.map((subCategory) {
                          return _buildCategoryTile(subCategory, '');
                        }).toList(),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
                ],
              );
            },
          ),
        );
      }),
    );
  }


  Widget _buildCategoryTile(Category category, String path) {
    if (category.subCategories.isEmpty) {
      return GestureDetector(
        onTap: () async {
          controller.updateSelectedSubcategoryPath(category, path);
          final selectedPath = controller.selectedSubcategoryPath.value;

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('selectedSubcategoryPath', selectedPath);
          print("gdfghdfbgdf++++++++++++++++++++++++        $selectedPath");
          Get.toNamed(Routes.ALL_PRODUCT);
        },
        child: Card(
          child: ListTile(
            title: Text(
              category.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
      );
    } else {
      return Card(
        child: ExpansionTile(
          title: Text(category.name),
          children: category.subCategories.map((subCategory) {
            return _buildCategoryTile(subCategory, '$path~${category.name}');
          }).toList(),
        ),
      );
    }
  }


}






