import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/custom_shapes/rounded_container.dart';
import 'package:shopsphere/utils/constant/colors.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';
class SOrderlistitem extends StatelessWidget {
  const SOrderlistitem({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    return ListView.separated(
        itemCount: 10,
        separatorBuilder: (context,index)=>SizedBox(height: SSize.spaceBtwItems,),
        itemBuilder: (context,index)=>SRoundedContainer(
          showBorder: true,
          backgroundColor: dark? SColors.dark: SColors.light,
          child: Padding(
            padding: const EdgeInsets.all(SSize.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //1 - row
                Row(
                  children: [

                    Icon(Iconsax.ship),
                    SizedBox(width: SSize.spaceBtwItems/2,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Processing",style: Theme.of(context).textTheme.bodyLarge!.apply(color: SColors.primary,fontWeightDelta: 1),),
                        //SizedBox(height: SSize.spaceBtwItems/2,),
                        Text("1 Jan,2026",style: Theme.of(context).textTheme.headlineSmall,)
                      ],
                    ),
                    Spacer(),
                    IconButton(onPressed: (){}, icon: Icon(Iconsax.arrow_right_34,size: SSize.iconSm,),)
                  ],
                ),
                SizedBox(height: SSize.spaceBtwItems,),

                //2 -row----
                Row(
                  children: [
                    //order
                    Expanded(
                      child: Row(
                        children: [

                          Icon(Iconsax.tag),
                          SizedBox(width: SSize.spaceBtwItems/2,),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Order",style: Theme.of(context).textTheme.bodyLarge,),
                              //SizedBox(height: SSize.spaceBtwItems/2,),
                              Text("#3464616",style: Theme.of(context).textTheme.headlineSmall,)
                            ],
                          ), ],
                      ),
                    ),
                    //date
                    Expanded(
                      child: Row(
                        children: [

                          Icon(Iconsax.calendar),
                          SizedBox(width: SSize.spaceBtwItems/2,),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Shipping Date",style: Theme.of(context).textTheme.bodyLarge,),
                              //SizedBox(height: SSize.spaceBtwItems/2,),
                              Text("4 Jan,2026",style: Theme.of(context).textTheme.headlineSmall,)
                            ],
                          ), ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
