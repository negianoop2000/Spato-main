import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';

import '../../../data/model/category_productList.dart';



class AllcategoryController extends GetxController {
  var isLoading = false.obs;
  var mainCategories = <MainCategory>[].obs;
  var subCategories = <Category>[].obs;

  var selectedMainCategory = Rx<MainCategory?>(null);
  var selectedSubcategoryPath = ''.obs;


  var expandedCategories = <Category>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await  getMainProductCategoryData();

  }

  List<String>? savedHerstNr;

  Future<void> getMainProductCategoryData() async {
    try {
      isLoading(true);


      var responseforuserid = await ApiService().fetchuserid(globalShopId??"");

      print(responseforuserid);

      String userid = responseforuserid['b2b_id']?? responseforuserid['userId'].toString();
      var response = await ApiService().getMainCategory(userid: userid);
      print("API Response: $response"); // Debugging line
      if (response != null && response['getMainCategory1'] != null) {
        mainCategories.assignAll(parseCategories(response['getMainCategory1']));
        print("Parsed Categories: ${mainCategories.toList()}"); // Debugging line
      }
    } catch (e) {
      print("Error fetching main product category data: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> GetFilteredCategory(String mainCategory, List<int> selectedSupplierIndexes) async {
    try {
      isLoading(true);

      final prefs = await SharedPreferences.getInstance();
      List<String> selectedOptions = prefs.getStringList('selectedOptions') ?? [];
      List<String> selectedHerstNr = prefs.getStringList('selectedHerstNr') ?? [];

      // Convert selectedHerstNr to List<int> if necessary
      List<int> selectedSupplierIndexes = selectedHerstNr.map((e) => int.tryParse(e) ?? 0).toList();
      var response = await ApiService().getDynamicFilterCategory(mainCategory, selectedSupplierIndexes);

      if (response != null) {
        var subCategoriesData = response['Kategorie_2'];

        if (subCategoriesData is Map<String, dynamic> || subCategoriesData is List<dynamic>) {
          subCategories.assignAll(parseSubCategories(subCategoriesData));
        } else {
          print("Unexpected type for Kategorie_2: ${subCategoriesData.runtimeType}");
        }
      } else {
        print("No filtered categories found for $mainCategory");
      }
    } catch (e) {
      print("Error filtering categories: $e");
    } finally {
      isLoading(false);
    }
  }


  var allProductList = <ProductList>[].obs;
  var products = <ProductList>[].obs;


  Future<void> productCategoriesApi(String category) async {
    print("Selected Category: $category");
    isLoading(true);
    try {
      var responseforuserid = await ApiService().fetchuserid(globalShopId);

      print(responseforuserid);

      String userid = responseforuserid['b2b_id'] ?? "";
      var response = await ApiService().productCategories(category,userid);
      if (response != null) {
        var allProduct = response['allProduct'] as List<dynamic>? ?? [];

        allProductList.clear();
        allProductList.addAll(allProduct.map((data) => ProductList.fromJson(data)).toList());

        // Fetch images for products
        for (var product in allProductList) {
          if (product.bild1 != null) {
            await get_image(product.bild1!);
          }
        }

        // Update products list
        products.value = allProductList;

        update();
      }
    } catch (e) {
      print("Exception caught: $e");
    } finally {
      isLoading(false);
      print("isLoading set to false");
    }
  }

  Future<void> get_image(String imageBuild) async {
    try {
      var response = await ApiService().get_Image(imageBuild);

      if (response is Map<String, dynamic>) {
        if (response.containsKey('message') && response['message'] == "Image not found!") {
          print("Image not found. Using dummy asset image.");
          var dummyImageUrl = "assets/images/no-item-found.png";

          for (var product in allProductList) {
            if (product.bild1 == imageBuild) {
              product.imageUrl = dummyImageUrl;
            }
          }
        } else if (response.containsKey('url')) {
          var imageUrl = response['url'];

          for (var product in allProductList) {
            if (product.bild1 == imageBuild) {
              product.imageUrl = imageUrl;
            }
          }
        } else {
          print("Unexpected response format");
        }

        // Update the products list to reflect changes
        products.value = allProductList;
      } else {
        print("Response is not a valid Map");
      }
    } catch (e) {
      print("Exception caught: $e");
    }
  }


  List<Category> parseSubCategories(dynamic json) {
    List<Category> parsedCategories = [];

    if (json is Map<String, dynamic>) {
      json.forEach((key, value) {
        List<Category> subCategories = parseSubCategories(value);
        parsedCategories.add(Category(
          id: key,
          name: key,
          subCategories: subCategories,
        ));
      });
    } else if (json is List<dynamic>) {
      parsedCategories = json.map((item) {
        return Category(
          id: item.toString(),
          name: item.toString(),
        );
      }).toList();
    }

    return parsedCategories;
  }


  List<MainCategory> parseCategories(List<dynamic> json) {
    return json.map((entry) {
      String name = entry['categorie_1'];
      String imagePath;

      switch (name) {
        case 'Technik':
          imagePath = 'assets/icons/technology.jpg';
          break;
        case 'Attraktionen':
          imagePath = 'assets/icons/attractionicon.jpg';
          break;
        case 'Wasserpflege':
          imagePath = 'assets/icons/water.jpg';
          break;
        case 'Pools':
          imagePath = 'assets/icons/pool_icon.jpg';
          break;
        case 'Verrohrung':
          imagePath = 'assets/icons/pipe.jpg';
          break;
        default:
          imagePath = 'assets/images/no-item-found.png';
          break;
      }

      return MainCategory(
        id: name,
        name: name,
        imagePath: imagePath,
      );
    }).toList();
  }

  void selectMainCategory(MainCategory category) {
    selectedMainCategory.value = category;
    List<int> selectedSupplierIndexes = savedHerstNr?.map(int.parse).toList() ?? [];
    GetFilteredCategory(category.name, selectedSupplierIndexes);
  }

  void updateSelectedSubcategoryPath(Category category, String path) {
    String newPath = path.isEmpty ? category.name : '$path~${category.name}';
    selectedSubcategoryPath.value = newPath;
  }
}

class MainCategory {
  final String id;
  final String name;
  final String? imagePath;

  MainCategory({
    required this.id,
    required this.name,
    this.imagePath,
  });
}
class Category {
  final String id;
  final String name;
  final List<Category> subCategories;
  final String? imagePath;

  Category({
    required this.id,
    required this.name,
    this.subCategories = const [],
    this.imagePath,
  });
}

