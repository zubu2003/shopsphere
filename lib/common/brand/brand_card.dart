import 'package:flutter/material.dart';
import 'package:shopsphere/common/texts/brand_title.dart';
import 'package:shopsphere/features/shop/models/brand_model.dart';

import '../../utils/constant/size.dart';
import '../custom_shapes/rounded_container.dart';
import '../images/SRouundImage.dart';
import '../texts/brand_title_with_verify_icon.dart';
class SBrandCard extends StatelessWidget {
  const SBrandCard({
    super.key, this.showBorder=true, this.onTap, required this.brand,
  });

  final bool showBorder;
  final VoidCallback? onTap;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SRoundedContainer(
        showBorder: showBorder,
        height: SSize.brandCardHeight,
        padding: EdgeInsets.all(SSize.sm),
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            //brand image
            Flexible(child: SRoundedImage(
              imageUrl: brand.image,
              isNetworkImage: true,
              backgroundColor: Colors.transparent,)
            ),
            SizedBox(width: SSize.spaceBtwItems / 2,),
            //title and icon
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SBrandTitleWithVerifyIcon(
                    title: brand.name,
                    brandTextSize:TextSizes.large,
                  ),
                  Text("${brand.productsCount} product",style: Theme.of(context).textTheme.labelMedium,overflow: TextOverflow.ellipsis,)
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

