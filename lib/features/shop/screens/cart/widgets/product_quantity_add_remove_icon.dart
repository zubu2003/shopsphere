import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/icon/circular_icon.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/size.dart';
import '../../../../../utils/helper/helper_functions.dart';

class SProductQuantityWithAddRemove extends StatelessWidget {
  const SProductQuantityWithAddRemove({
    super.key, required this.quantity, this.add, this.remove,
  });

  final int quantity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(width: 70,),
        /// Decrement Button
        SCircularIcon(
          icon: Iconsax.minus, width: 32,height: 32,
          size: SSize.iconSm,
          color: dark ? SColors.white : SColors.black,
          backgroundColor: dark ? SColors.darkerGrey : SColors.light,
          onPressed: remove,
        ), // UCircutarIcon
        SizedBox(width: SSize.spaceBtwItems),

        /// Counter Text
        Text(
            quantity.toString(),
            style: Theme
                .of(context)
                .textTheme
                .titleSmall
        ), // Text
        SizedBox(width: SSize.spaceBtwItems),

        /// increment Button
        SCircularIcon(
          icon: Iconsax.add, width: 32,height: 32,
          size: SSize.iconSm,
          color: SColors.white,
          backgroundColor: SColors.primary,
          onPressed: add,
        ),
      ],
    );
  }
}
