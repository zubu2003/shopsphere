import 'package:flutter/material.dart';
import 'package:shopsphere/features/shop/models/brand_model.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';
import '../custom_shapes/rounded_container.dart';
import 'brand_card.dart';
class SbrandShowCase extends StatelessWidget {
  const SbrandShowCase({
    super.key, required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    return SRoundedContainer(
      showBorder: true,
      borderColor: SColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.all(SSize.md),
      margin: EdgeInsets.only(bottom: SSize.spaceBtwItems),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //brand with product count
          SBrandCard(showBorder: false,brand: BrandModel.empty(),),

          //product image
          Row(
             children: images.map((image)=> buildBrandImage(dark,image)).toList(),

          ),
        ],
      ),
    );
  }

  Widget buildBrandImage(bool dark,String imagePath) {
    return Expanded(
      child: SRoundedContainer(
            height: 100,
            margin: EdgeInsets.only(right: SSize.sm),
            padding: EdgeInsets.all(SSize.md),
            backgroundColor: dark? SColors.darkGrey : SColors.white,
            child: Image(image: AssetImage(imagePath),fit: BoxFit.contain),
          ),
    );
  }
}
