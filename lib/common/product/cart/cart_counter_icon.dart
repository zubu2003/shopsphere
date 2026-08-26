import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/features/shop/controllers/cart/cart_controller.dart';
import 'package:shopsphere/features/shop/screens/cart/cart.dart';

import '../../../utils/constant/colors.dart';
import '../../../utils/constant/size.dart';
import '../../../utils/helper/helper_functions.dart';

class SCartCounterIcon extends StatelessWidget {
  const SCartCounterIcon({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    final cartController=Get.put(CartController());

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
            child: Obx(
              ()=> Center(
                child: Text(cartController.noOfCartItems.value.toString(), style: Theme
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
        ),

      ],
    );
  }
}
