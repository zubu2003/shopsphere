import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/utils/constant/colors.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../../../../common/custom_shapes/rounded_container.dart';
import '../../../../../utils/constant/size.dart';
class SSingleAddress extends StatelessWidget {
  const SSingleAddress({
    super.key, required this.isSelected,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    return SRoundedContainer(
      width: double.infinity,
      showBorder: true,
      backgroundColor: isSelected? SColors.primary.withValues(alpha: 0.5): Colors.transparent,
      borderColor: isSelected? Colors.transparent : dark? SColors.darkGrey:SColors.grey,
      padding: EdgeInsets.all(SSize.md),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Shopsphere",style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: SSize.spaceBtwItems,),
              Text("+8801859322440",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: SSize.spaceBtwItems,),
              Text("house-1,road-1,dhaka,bangladesh"),

            ],
          ),

          //selected button
          if(isSelected)Positioned(
            top: 0,
              right: 0,
              bottom: 0,
              child: Icon(Iconsax.tick_circle5)
          ),
        ],
      ),
    );
  }
}
