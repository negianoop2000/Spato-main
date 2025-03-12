import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/app/data/model/category_productList.dart';
import 'package:spato_mobile_app/app/data/model/products_list.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';

import '../../myCart/controllers/my_cart_controller.dart';


class AllProductController extends GetxController {
  var products = <ProductList>[].obs;
  late String selectedCategory;
  late String mainCategory;

  late String selectedSubCategory;
  late String Category;
  late String selectedImage;
  var isLoading = false.obs;
  List<String>? savedHerstNr;

  @override
  void onInit() async{
    super.onInit();
   await loadSavedOptions();
  }

  Future<void> loadSavedOptions() async {
    final prefs = await SharedPreferences.getInstance();
    mainCategory = prefs.getString("MainCategory")??'';

    selectedCategory = prefs.getString("selectedMainCategoryName") ?? '';
    selectedSubCategory = prefs.getString("selectedSubcategoryPath") ?? '';
    const find = '~~';
    const replaceWith = '~';
    Category = "$selectedCategory~$selectedSubCategory";
    final newString = Category.replaceAll(find, replaceWith);
    savedHerstNr = prefs.getStringList('selectedHerstNr');
    List<int> selectedSupplierIndexes = savedHerstNr?.map(int.parse).toList() ?? [];


    if(mainCategory!=""){
      await GetFilteredProduct(mainCategory, selectedSupplierIndexes);
    }else{
      await GetFilteredProduct(newString, selectedSupplierIndexes);

    }
  }

  Future<void> GetFilteredProduct(String mainCategory, List<int> selectedSupplierIndexes) async {
    isLoading(true);
    try {
      var response = await ApiService().getFilterProducts(mainCategory, selectedSupplierIndexes);

      if (response != null && response['allProduct'] != null) {
        var allProduct = response['allProduct'] as List;
        products.clear();
        products.addAll(allProduct.map((data) => ProductList.fromJson(data)).toList());
        await Future.wait(products.map((product) async {

          if (product.bild1 != null && product.bild1!.isNotEmpty) {
            await get_image(product.bild1!);
          }
        }));

      }
    } catch (e) {
      print("error $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> get_image(String imageBuild) async {
    try {
      var response = await ApiService().get_Image(imageBuild);

      if (response is Map<String, dynamic>) {
        if (response.containsKey('message') && response['message'] == "Image not found!") {
          var dummyImageUrl = "assets/images/no-item-found.png";
          for (var product in products) {
            if (product.bild1 == imageBuild) {
              product.imageUrl = dummyImageUrl;
            }
          }
        } else if (response.containsKey('url')) {
          var imageUrl = response['url'];
          for (var product in products) {
            if (product.bild1 == imageBuild) {
              product.imageUrl = imageUrl;
            }
          }
        }
      }
    } catch (e) {
      print("error $e");
    }
  }


  Future<void> addToCartApi(String productid) async {
  //  isLoading(true);
    try {
      var response = await ApiService().addToCardApi(
        productid,
        1,
      );
      if (response['message'] == "Item added to cart successfully") {
        Get.snackbar('Success', response['message'], duration: Duration(seconds: 1));
        final MyCartController cartcontroller = Get.put(MyCartController());
        cartcontroller.cartcount.value++;
      } else {
        Get.snackbar('Error', 'Added to cart unsuccessfully', duration: Duration(seconds: 1));
      }
    } finally {
   //   isLoading(false);
    }
  }

  String formatPrice(String price) {
    try {
      String normalizedPrice = price.replaceAll(',', '.');
      double? parsedPrice = double.tryParse(normalizedPrice);
      return parsedPrice != null ? parsedPrice.toStringAsFixed(2) : '0.00';
    } catch (e) {
      return '0.00';
    }
  }


  void setProducts(List<ProductList> productList) {
    products.assignAll(productList);
  }

  void setSelectedImage(String image) {
    selectedImage = image;
  }
}


