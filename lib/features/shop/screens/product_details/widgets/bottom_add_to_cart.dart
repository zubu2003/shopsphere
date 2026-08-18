import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/icon/circular_icon.dart';
import 'package:shopsphere/utils/constant/colors.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);

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
      child: Row(
        children: [
          //decreament icon
          SCircularIcon(icon: Iconsax.minus,height: 40,width: 40,backgroundColor:SColors.darkerGrey ,color: SColors.light,),
          SizedBox(width: SSize.spaceBtwItems,),

          Text("2",style: Theme.of(context).textTheme.titleSmall!.apply(color: SColors.dark),),
          SizedBox(width: SSize.spaceBtwItems,),

          //increament icon
          SCircularIcon(icon: Iconsax.add,height: 40,width: 40,backgroundColor:SColors.dark ,color: SColors.white,),
          Spacer(),

          //add to cart
          ElevatedButton(
            onPressed: (){},
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
    );
  }
}
