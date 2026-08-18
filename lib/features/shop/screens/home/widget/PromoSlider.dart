import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/common/shimmer/shimmer_effect.dart';
import 'package:shopsphere/features/shop/controllers/banner/banner_controller.dart';
import 'package:shopsphere/features/shop/controllers/homeController.dart';

import '../../../../../common/images/SRouundImage.dart';
import '../../../../../utils/constant/size.dart';
import 'bannerIndicator.dart';

class SPromoSlider extends StatelessWidget {
  const SPromoSlider({
    super.key
  });


  @override
  Widget build(BuildContext context) {
    final bannerController= Get.put(BannerController());
    return Obx(
      (){

        if(bannerController.isloading.value) {
          return SShimmerEffect(width: double.infinity, height: 190);
        }

          if(bannerController.banners.isEmpty) {
            return Text('Banners Not Found');
          }


        return  Column(
          children: [
            //image slider
            CarouselSlider(
              items: bannerController.banners.map((banner)=> SRoundedImage(imageUrl: banner.imageUrl,isNetworkImage: true,onTap: ()=> Get.toNamed(banner.targetScreen),)).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index,reason)=> bannerController.onPageChanged(index),
              ) ,
              carouselController: bannerController.carouselController,
            ),

            SizedBox(height: SSize.spaceBtwItems,),
            //indicator
            BannerDotNavigation(),
          ],
        );
      }
    );
  }
}
