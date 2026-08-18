import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/features/shop/screens/cart/cart.dart';

import '../../../utils/constant/colors.dart';
import '../../../utils/constant/size.dart';

class SCartCounterIcon extends StatelessWidget {
  const SCartCounterIcon({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: ()=> Get.to(()=> CartScreen()),
            icon: Icon(Iconsax.shopping_bag,color: SColors.white,)),

        Positioned(
          right: 7,
          child: Container(
            height: SSize.md,
            width: SSize.md,
            decoration: BoxDecoration(
              color:dark? SColors.white : SColors.dark,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text("2", style: Theme
                  .of(context)
                  .textTheme
                  .labelMedium !
                  .apply(
                  color: dark? SColors.dark :SColors.grey,
                  fontSizeFactor: 0.8)
              ),
            ),
          ),
        ),

      ],
    );
  }
}
