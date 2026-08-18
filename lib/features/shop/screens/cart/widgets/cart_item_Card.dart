import 'package:flutter/material.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../../../../common/images/SRouundImage.dart';
import '../../../../../common/texts/brand_title_with_verify_icon.dart';
import '../../../../../common/texts/product_title.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/image_string.dart';
import '../../../../../utils/constant/size.dart';

class SCartItem extends StatelessWidget {
  const SCartItem({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    final dark= SHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        //image
        SRoundedImage(
          imageUrl: SImages.productImage4a,
          height: 60,
          width: 60,
          padding: EdgeInsets.all(SSize.sm),
          backgroundColor: dark? SColors.darkGrey : SColors.light,
        ),
        SizedBox(width: SSize.spaceBtwItems,),
        //brand name variation
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SBrandTitleWithVerifyIcon(title: "Apple"),
              SProductTitle(title: "Iphone 11 8/128GB"),

              //variation
              RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(text: 'Color ',style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(text: 'Red ',style: Theme.of(context).textTheme.bodyLarge),
                        TextSpan(text: 'Storage ',style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(text: '128GB ',style: Theme.of(context).textTheme.bodyLarge),
                      ]
                  )
              )
            ],
          ),
        ),
      ],
    );
  }
}


