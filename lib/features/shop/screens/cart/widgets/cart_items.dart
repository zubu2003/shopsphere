import 'package:flutter/material.dart';
import 'package:shopsphere/features/shop/screens/cart/widgets/product_quantity_add_remove_icon.dart';

import '../../../../../common/texts/product_price.dart';
import '../../../../../utils/constant/size.dart';
import 'cart_item_Card.dart';
class SCartItems extends StatelessWidget {
  const SCartItems({
    super.key, this.showAddRemoveButton=true,
  });

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 2,
      separatorBuilder: (context,index)=>SizedBox(height: SSize.spaceBtwItems,),
      itemBuilder: (context,index)=>
          Column(
            children: [
              SCartItem(),
              SizedBox(height: SSize.spaceBtwItems),

              if(showAddRemoveButton) Row(
                  children: [

                    SProductQuantityWithAddRemove(),
                    Spacer(),

                    //price
                    SProductPrice(price: "250",isLarge: false,),

                  ]
              ),

            ],
          ),

      //counter price



    );
  }
}
