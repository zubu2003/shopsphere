import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../../../../common/appbar/SAppbar.dart';
import '../../../../../common/icon/circular_icon.dart';
import '../../../../../common/images/SRouundImage.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/image_string.dart';
import '../../../../../utils/constant/size.dart';

class SProductThumbnailAndSlider extends StatelessWidget {
  const SProductThumbnailAndSlider({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
  final bool dark=SHelperFunctions.isDarkMode(context);
    return Container(
      color: dark? SColors.darkGrey: SColors.light,
      child: Stack(
        children: [
          //image
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(SSize.productImageRadius * 2),
              child: Center(child: Image(image: AssetImage(SImages.productImage4a))),
            ),
          ),
          //slider image
          Positioned(
            left: SSize.defaultSpace,
            right: 0,
            bottom: 30,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                itemCount: 9,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context,index)=>SizedBox(width: SSize.spaceBtwItems,) ,
                itemBuilder: (context,index)=> SRoundedImage(
                    width: 80,
                    backgroundColor: dark? SColors.dark: SColors.white,
                    padding: EdgeInsets.all(SSize.sm),
                    border: Border.all(color: SColors.primary),
                    imageUrl: SImages.productImage4b
                ) ,
              ),
            ),
          ),

          //appbar
          SAppBar(
            showLeading: true,
            actions: [SCircularIcon(icon: Iconsax.heart5,color: Colors.red,)],
          ),

        ],
      ),
    );
  }
}
