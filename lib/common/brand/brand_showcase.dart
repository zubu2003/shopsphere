import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/features/shop/models/brand_model.dart';
import 'package:shopsphere/features/shop/screens/brands/brand_products.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';
import '../custom_shapes/rounded_container.dart';
import '../shimmer/shimmer_effect.dart';
import 'brand_card.dart';
class SbrandShowCase extends StatelessWidget {
  const SbrandShowCase({
    super.key, required this.images, required this.brand,
  });

  final List<String> images;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    return InkWell(
      onTap: ()=>Get.to(()=>BrandProductsScreen(title: brand.name, brand: brand)),
      child: SRoundedContainer(
        showBorder: true,
        borderColor: SColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.all(SSize.md),
        margin: EdgeInsets.only(bottom: SSize.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //brand with product count
            SBrandCard(showBorder: false,brand: brand,),
      
            //product image
            Row(
               children: images.map((image)=> buildBrandImage(dark,image)).toList(),
      
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBrandImage(bool dark,String imagePath) {
    return Expanded(
      child: SRoundedContainer(
            height: 100,
            margin: EdgeInsets.only(right: SSize.sm),
        padding: EdgeInsets.all(SSize.md),
        backgroundColor: dark ? SColors.darkGrey : SColors.white,
        child: CachedNetworkImage(
          imageUrl: imagePath,
          fit: BoxFit.contain,
          progressIndicatorBuilder: (context, url, progress) {
            return SShimmerEffect(width: 100, height: 100,);
          },
          errorWidget: (context, url, error) =>
          const Icon(
            Icons.error,
          ),
        ),

    ),
    );
  }
}
