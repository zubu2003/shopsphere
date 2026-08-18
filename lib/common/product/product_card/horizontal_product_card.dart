import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/texts/brand_title_with_verify_icon.dart';
import 'package:shopsphere/common/texts/product_price.dart';
import 'package:shopsphere/common/texts/product_title.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../custom_shapes/rounded_container.dart';
import '../../icon/circular_icon.dart';
import '../../images/SRouundImage.dart';
import '../../../utils/constant/colors.dart';
import '../../../utils/constant/image_string.dart';
import '../../../utils/constant/size.dart';

class SProductCardHorizontal extends StatelessWidget {
  const SProductCardHorizontal({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SSize.productImageRadius),
        color: dark? SColors.darkGrey: SColors.light,
      ),
      child: Row(
        children: [
          //left portion
          SRoundedContainer(
            height: 120,
            padding: EdgeInsets.all(SSize.sm),
            backgroundColor: dark? SColors.dark: SColors.light,
            child: Stack(
              children: [
                SizedBox(
                  height:120,
                  width: 120,
                  child: SRoundedImage(imageUrl: SImages.productImage15),
                ),
                Positioned(
                  top: 12,
                  child: SRoundedContainer(
                    radius: SSize.sm,
                    backgroundColor: SColors.yellow.withValues(alpha: 0.8),
                    padding: EdgeInsets.symmetric(horizontal: SSize.sm,vertical: SSize.xs),
                    child: Text("20%",style: Theme.of(context).textTheme.labelMedium!.apply(color: SColors.dark),),
                  ),
                ),
                //fav tag
                Positioned(
                    right: 0,
                    top: 0,
                    child: SCircularIcon(
                      icon: Iconsax.heart5,
                      color: Colors.red,

                    )
                ),
              ],
            ) ,
          ),

          //right portion
          SizedBox(
            width: 172.0,
            child: Padding(
              padding:EdgeInsetsGeometry.only(left: SSize.sm,top: SSize.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //product name and brand
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SProductTitle(title: "Blue Bata Shoes",smallLine: true,),
                      SizedBox(height: SSize.spaceBtwItems/2,),

                      //brand
                      SBrandTitleWithVerifyIcon(title: "Bata"),
                    ],
                  ),
                  Spacer(),
                  //price and add button
                  Row(
                    children: [
                      SProductPrice(price: "300"),
                      Spacer(),
                      Container(
                        height: SSize.iconLg *1.2,
                        width: SSize.iconLg *1.2,
                        decoration: BoxDecoration(
                          color: SColors.primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(SSize.productImageRadius),
                            bottomRight: Radius.circular(SSize.productImageRadius),
                          ),
                        ),
                        child: Icon(Iconsax.add,color: Colors.white),
                      ),
                    ],
                  ),



                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
