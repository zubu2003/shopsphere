import 'package:get/get.dart';
import 'package:shopsphere/data/repositories/category/category_repository.dart';
import 'package:shopsphere/features/shop/models/category_model.dart';
import 'package:shopsphere/utils/popups/snackbar_helpers.dart';

import '../../../../data/repositories/product/product_repository.dart';
import '../../models/product_model.dart';

class CategoryController extends GetxController{

  static CategoryController get instance => Get.find();

  //varaibles
  final _repository= Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories= <CategoryModel>[].obs;
  RxList<CategoryModel> feautredCategories= <CategoryModel>[].obs;

  RxBool isCategoriesLoading = false.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();

  }

  /// Function to get all categories & featured categories from Firebase
  Future<void> fetchCategories() async {
    try{
      isCategoriesLoading.value=true;

      //fetch categories
      List<CategoryModel> categories = await _repository.getAllCategories();
      allCategories.assignAll(categories);

      //get featured categories
      feautredCategories.assignAll(categories.where((category)=> category.isFeatured==true && category.parentId.isEmpty));

    }catch(e) {
      SSnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
    }finally{
      isCategoriesLoading.value=false;
    }
  }

  /// Get Category Products
  Future<List<ProductModel>> getCategoryProducts({
    required String categoryId,
    int limit = -1,
  }) async {
    try {
      // Get products for the specific category
      final products = await ProductRepository.instance
          .getProductsForCategory(categoryId: categoryId,limit: limit,);

      return products;
    } catch (e) {
      // Show error message
      SSnackBarHelpers.errorSnackBar(
        title: 'Failed!',
        message: e.toString(),
      );

      return [];
    }
  }



}