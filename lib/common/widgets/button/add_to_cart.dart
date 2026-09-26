import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/features/shop/controllers/cart/cart_controller.dart';
import 'package:shopsphere/features/shop/models/cart_item_model.dart';
import 'package:shopsphere/features/shop/models/product_model.dart';
import 'package:shopsphere/features/shop/screens/product_details/product_details.dart';
import 'package:shopsphere/utils/constant/enums.dart';

import '../../../utils/constant/colors.dart';
import '../../../utils/constant/size.dart';

class ProductAddToCartButton extends StatelessWidget {
  const ProductAddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController=Get.put(CartController());

    return InkWell(
      onTap: (){
        if(product.productType== ProductType.single.toString()){
          CartItemModel cartItem=cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);

        }else{
          Get.to(()=> ProductDetailsScreen(product: product));
        }

        
      },
      child: Obx(
        (){
          int productQuantityInCart=cartController.getProductQuantityInCart(product.id);

          return Container(
            height: SSize.iconLg *1.2,
            width: SSize.iconLg *1.2,
            decoration: BoxDecoration(
              color: productQuantityInCart>0 ? SColors.dark : SColors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(SSize.productImageRadius),
                bottomRight: Radius.circular(SSize.productImageRadius),
              ),
            ),
            child:Center(
              child: productQuantityInCart>0 ? Text(productQuantityInCart.toString(),style: Theme.of(context).textTheme.labelMedium!.apply(color: SColors.white),) : Icon(Iconsax.add,color: Colors.white),
            )
          );
        }
      ),
    );
  }
}
