import 'package:flutter/material.dart';

import '../../../../../common/custom_shapes/rounded_container.dart';
import '../../../../../common/images/circular_image.dart';
import '../../../../../common/texts/brand_title_with_verify_icon.dart';
import '../../../../../common/texts/product_price.dart';
import '../../../../../common/texts/product_title.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/image_string.dart';
import '../../../../../utils/constant/size.dart';
class SProductMetaData extends StatelessWidget {
  const SProductMetaData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SRoundedContainer(
              radius: SSize.sm,
              backgroundColor: SColors.yellow.withValues(alpha: 0.8),
              padding: EdgeInsets.symmetric(horizontal: SSize.sm,vertical: SSize.xs),
              child: Text("20%",style: Theme.of(context).textTheme.labelMedium!.apply(color: SColors.dark),),
            ),
            SizedBox(width: SSize.spaceBtwItems,),

            //price
            SProductPrice(price: "250",lineThrough: true,isLarge: false,),
            SizedBox(width: SSize.spaceBtwItems,),

            SProductPrice(price: "150"),
            Spacer(),
            IconButton(onPressed: (){}, icon: Icon(Icons.share)),


          ],
        ),
        SizedBox(height: SSize.spaceBtwItems/1.5,),

        //product title
        SProductTitle(title: "Apple Iphone 11"),
        SizedBox(height: SSize.spaceBtwItems/1.5,),

        //status
        Row(
          children: [
            SProductTitle(title: "Status"),
            SizedBox(width: SSize.spaceBtwItems),
            Text("In stock",style: Theme.of(context).textTheme.titleMedium,),
          ],
        ),
        SizedBox(height: SSize.spaceBtwItems/1.5,),

        Row(
          children: [
            SCircularImage(image: SImages.appleLogo,
              width: 32,
              height: 32,
              showBorder: false,
            ),
            SizedBox(width: SSize.spaceBtwItems,),
            SBrandTitleWithVerifyIcon(title: "Apple"),
          ],
        ),

        //row
      ],
    );
  }
}
