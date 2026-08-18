import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/banner/banner_repository.dart';
import '../../../../utils/popups/snackbar_helpers.dart';
import '../../models/banners_model.dart';
class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  /// Variables
  final _repository = Get.put(BannerRepository());
  RxList<BannerModel> banners = <BannerModel>[].obs;
  RxBool isloading=false.obs;

  final carouselController = CarouselSliderController();
  RxInt currentIndex=0.obs;


  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void onPageChanged(int index){
    currentIndex.value=index;
  }

  Future<void> fetchBanners() async {
    try {
      isloading.value=true;

      List<BannerModel> activeBanners = await _repository.fetchActiveBanner();
      banners.assignAll(activeBanners);

    } catch (e) {
      SSnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    }finally{
      isloading.value=false;
    }
  }
}