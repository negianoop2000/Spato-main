import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spato_mobile_app/utils/constants/api_service.dart';



class AllcategoryController extends GetxController {
  var isLoading = false.obs;
  var mainCategories = <MainCategory>[].obs;
  var subCategories = <Category>[].obs;

  var selectedMainCategory = Rx<MainCategory?>(null);
  var selectedSubcategoryPath = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await  getMainProductCategoryData();

  }

  List<String>? savedHerstNr;

  // Future<void> loadSavedOptions() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   List<String>? savedOptions = prefs.getStringList('selectedOptions');
  //   savedHerstNr = prefs.getStringList('selectedHerstNr');
  //
  //   if (savedOptions != null && savedHerstNr != null) {
  //     print("Loaded options: ${savedOptions.join(', ')}");
  //     print("Loaded Herst_Nr: ${savedHerstNr!.join(', ')}");
  //     for (int i = 0; i < savedOptions.length; i++) {
  //       print("Option: ${savedOptions[i]}, Herst_Nr: ${savedHerstNr![i]}");
  //     }
  //     getMainProductCategoryData();
  //   } else {
  //     print("No saved options or Herst_Nr found");
  //   }
  // }

  Future<void> getMainProductCategoryData() async {
    try {
      isLoading(true);
      var response = await ApiService().getMainCategory();
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


  // Future<void> GetFilteredCategory(String mainCategory, List<int> selectedSupplierIndexes) async {
  //   try {
  //     isLoading(true);
  //     var response = await ApiService().getDynamicFilterCategory(mainCategory, selectedSupplierIndexes);
  //     if (response != null && response['Kategorie_2'] != null) {
  //       var subCategoriesData = response['Kategorie_2'];
  //       subCategories.assignAll(parseSubCategories(subCategoriesData));
  //     } else {
  //       print("No filtered categories found for $mainCategory");
  //     }
  //   } catch (e) {
  //     print("Error filtering categories: $e");
  //   } finally {
  //     isLoading(false);
  //   }
  // }

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


  // List<Category> parseSubCategories(Map<String, dynamic> json) {
  //   List<Category> parsedCategories = [];
  //
  //   json.forEach((key, value) {
  //     List<Category> subCategories = [];
  //     if (value is Map<String, dynamic>) {
  //       subCategories = parseSubCategories(value);
  //     }
  //
  //     parsedCategories.add(Category(
  //       id: key,
  //       name: key,
  //       subCategories: subCategories,
  //     ));
  //   });
  //
  //   return parsedCategories;
  // }

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

