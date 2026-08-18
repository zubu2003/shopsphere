import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/data/repositories/brand/brand_repositories.dart';
import 'package:shopsphere/features/shop/models/brand_model.dart';

import '../../../../utils/popups/snackbar_helpers.dart';

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

}