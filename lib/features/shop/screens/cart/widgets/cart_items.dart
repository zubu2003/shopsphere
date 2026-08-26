import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/features/shop/screens/cart/widgets/product_quantity_add_remove_icon.dart';

import '../../../../../common/texts/product_price.dart';
import '../../../../../utils/constant/size.dart';
import '../../../controllers/cart/cart_controller.dart';
import 'cart_item_Card.dart';
class SCartItems extends StatelessWidget {
  const SCartItems({
    super.key, this.showAddRemoveButton=true,
  });

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final cartController=CartController.instance;

    return ListView.separated(
      shrinkWrap: true,
      itemCount: cartController.cartItems.length,
      separatorBuilder: (context,index)=>SizedBox(height: SSize.spaceBtwItems,),
      itemBuilder: (context,index){
        return Obx(
            (){
              final cartItem=cartController.cartItems[index];

              return Column(
                children: [
                  SCartItem(cartItem: cartItem,),
                  SizedBox(height: SSize.spaceBtwItems),

                  if(showAddRemoveButton) Row(
                      children: [

                        SProductQuantityWithAddRemove(
                          quantity:cartItem.quantity,
                          add: ()=> cartController.addOneToCart(cartItem),
                          remove: ()=> cartController.removeOneFromCart(cartItem),
                        ),
                        Spacer(),

                        //price
                        SProductPrice(price: (cartItem.quantity * cartItem.price).toStringAsFixed(0),isLarge: false,),

                      ]
                  ),

                ],
              );
            }
        );
      }


      //counter price



    );
  }
}
