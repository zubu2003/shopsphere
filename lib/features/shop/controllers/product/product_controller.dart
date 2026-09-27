import 'package:get/get.dart';

import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/constant/enums.dart';
import '../../../../utils/popups/snackbar_helpers.dart';
import '../../models/product_model.dart';

class ProductController extends GetxController{

  static ProductController get instance => Get.find();

  /// Variables
  final _repository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxBool isLoading=false.obs;


  @override
  void onInit() {
    getFeaturedProduct();
    super.onInit();
  }

  /// Function to get all  products
  Future<List<ProductModel>> getAllProduct() async {
    try {
      //fetch all product
      List<ProductModel> featuredProducts = await _repository.fetchAllProducts();

      //assign products
      return featuredProducts;


    } catch (e) {
      SSnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
      return [];
    }
  }


  /// Function to get only 4 featured products
  Future<void> getFeaturedProduct() async {
    try {
      List<ProductModel> featuredProducts = await _repository.fetchFeatureProducts();
      this.featuredProducts.assignAll(featuredProducts);
    } catch (e) {
      SSnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    }
  }

  /// Function to get all featured products
  Future<List<ProductModel>> getAllFeaturedProduct() async {
    try {
      //fetch feature product
      List<ProductModel> featuredProducts = await _repository.fetchALlFeatureProducts();

      //assign products
      return featuredProducts;


    } catch (e) {
      SSnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
      return [];
    }
  }

  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0.0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;

    return percentage.toStringAsFixed(1);
  }

  /// Get product price or price range for variable product
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // If no variation exists, return the single price or sale price
    if (product.productType == ProductType.single.toString()) {
      return product.salePrice > 0
          ? product.salePrice.toString()
          : product.price.toString();
    } else {
      // Calculate the smallest and largest price among variations
      for (final variation in product.productVariations!) {
        double variationPrice =
        variation.salePrice > 0 ? variation.salePrice : variation.price;

        if (variationPrice > largestPrice) {
          largestPrice = variationPrice;
        }

        if (variationPrice < smallestPrice) {
          smallestPrice = variationPrice;
        }
      }

      if(smallestPrice.isEqual(largestPrice)){
        return largestPrice.toStringAsFixed(0);
      }else {
        return '${largestPrice.toStringAsFixed(0)} - ${smallestPrice.toStringAsFixed(0)}';
      }
    }
  }


  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
