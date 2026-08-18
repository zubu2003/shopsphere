import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/styles/shadow.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';
import '../../utils/constant/text_strings.dart';

class SSearchBar extends StatelessWidget {
  const SSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: 0,
      right: SSize.spaceBtwSections,
      left: SSize.spaceBtwSections,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: SSize.md),
        height: SSize.searchBarHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SSize.borderRadiusLg),
          color: dark? SColors.dark: SColors.white,
          boxShadow: SShadow.searchBoxShadow,
        ),
        child:Row(
          children: [
            Icon(Iconsax.search_normal),
            SizedBox(width: SSize.md,),
            Text(STexts.searchBarTitle,style: Theme.of(context).textTheme.bodySmall,),
          ],
        ) ,
      ),
    );
  }
}