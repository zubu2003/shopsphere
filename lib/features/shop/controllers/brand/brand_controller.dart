import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/data/repositories/brand/brand_repositories.dart';
import 'package:shopsphere/features/shop/models/brand_model.dart';

import '../../../../data/repositories/category/category_repository.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/popups/snackbar_helpers.dart';
import '../../models/product_model.dart';

class BrandController extends GetxController{

  static BrandController get instance => Get.find();

  ///variable
  final _repository=Get.put(BrandRepository());
  RxList<BrandModel> allbrands=<BrandModel>[].obs;
  RxList<BrandModel> featurebrands=<BrandModel>[].obs;
  RxBool isloading=false.obs;


  @override
  void onInit() {
    getBrands();
    super.onInit();
  }

  Future<void> getBrands()async{
    try{
      isloading.value=true;
    
      List<BrandModel> brands=await _repository.fetchBrands();
      allbrands.assignAll(brands);
      featurebrands.assignAll(allbrands.where((brand)=>brand.isFeatured ?? false).toList());

    }catch(e){
      SSnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    }finally{
      isloading.value=false;
    }
  }
  /// Get Brand Specific Products
  Future<List<ProductModel>> getBrandProducts(String brandId, {int limit=-1}) async {
    try {

      List<ProductModel> products= await ProductRepository.instance.getProductsForBrand(brandId: brandId,limit: limit);

      return products;

    } catch (e) {
      SSnackBarHelpers.errorSnackBar(
        title: 'Failed!',
        message: e.toString(),
      );
      return [];
    }
  }

  /// Get brands for specific category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {

      List<BrandModel> brands= await _repository.fetchBrandForCategory(categoryId);
      return brands;

    } catch (e) {
      SSnackBarHelpers.errorSnackBar(
        title: 'Failed!',
        message: e.toString(),
      );
      return [];
    }
  }

}