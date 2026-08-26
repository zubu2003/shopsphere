import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/icon/circular_icon.dart';
import 'package:shopsphere/features/shop/controllers/cart/cart_controller.dart';
import 'package:shopsphere/features/shop/models/product_model.dart';
import 'package:shopsphere/utils/constant/colors.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    final cartControlller=CartController.instance;

    cartControlller.updateAlreadyAddedProductCount(product);

    return Container(
      decoration: BoxDecoration(
        color: dark? SColors.grey :SColors.white ,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SSize.cardRadiusLg),
          topRight: Radius.circular(SSize.cardRadiusLg),
        )
      ),
      padding: EdgeInsets.symmetric(
          horizontal: SSize.defaultSpace,
          vertical: SSize.defaultSpace/2),
      child: Obx(
          ()=> Row(
          children: [
            //decreament icon
            SCircularIcon(
              icon: Iconsax.minus,
              height: 40,
              width: 40,
              backgroundColor:SColors.darkerGrey ,
              color: SColors.light,
              onPressed: cartControlller.productQuantityInCart.value < 1 ? null :()=> cartControlller.productQuantityInCart.value-=1
            ),
            SizedBox(width: SSize.spaceBtwItems,),

            Text(cartControlller.productQuantityInCart.value.toString(),style: Theme.of(context).textTheme.titleSmall!.apply(color: SColors.dark),),
            SizedBox(width: SSize.spaceBtwItems,),

            //increament icon
            SCircularIcon(
              icon: Iconsax.add,
              height: 40,
              width: 40,
              backgroundColor:SColors.dark ,
              color: SColors.white,
              onPressed:()=> cartControlller.productQuantityInCart.value+=1
            ),
            Spacer(),

            //add to cart
            ElevatedButton(
              onPressed: cartControlller.productQuantityInCart.value < 1 ? null :()=> cartControlller.addToCart(product),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(SSize.md),
                backgroundColor: Colors.black,
                side: BorderSide(
                    color: Colors.black,

                ),
              ),
                child: Row(
                  children: [
                    Icon(Iconsax.shopping_bag,color: SColors.white,),
                    SizedBox(width: SSize.spaceBtwItems/2,),
                    Text("Add to cart",style: Theme.of(context).textTheme.headlineSmall!.apply(color: SColors.white),)
                  ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
