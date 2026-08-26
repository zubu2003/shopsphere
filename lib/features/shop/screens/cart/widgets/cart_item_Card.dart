import 'package:flutter/material.dart';
import 'package:shopsphere/features/shop/models/cart_item_model.dart';
import 'package:shopsphere/features/shop/models/category_model.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../../../../common/images/SRouundImage.dart';
import '../../../../../common/texts/brand_title_with_verify_icon.dart';
import '../../../../../common/texts/product_title.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/image_string.dart';
import '../../../../../utils/constant/size.dart';

class SCartItem extends StatelessWidget {
  const SCartItem({
    super.key, required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final dark= SHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        //image
        SRoundedImage(
          imageUrl: cartItem.image?? '',
          isNetworkImage: true,
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
              SBrandTitleWithVerifyIcon(title: cartItem.brandName?? ''),
              SProductTitle(title: cartItem.title?? ''),

              //variation
              /// Variation OR Attributes
              RichText(
                text: TextSpan(
                  children: (cartItem.selectedVariation ?? {}).entries
                      .map(
                        (e) => TextSpan(
                      children: [
                        TextSpan(
                          text: '${e.key} ',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextSpan(
                          text: '${e.value} ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ).toList(),
                ),
              )

            ],
          ),
        ),
      ],
    );
  }
}


