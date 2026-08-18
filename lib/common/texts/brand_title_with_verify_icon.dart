import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';
import 'brand_title.dart';

class SBrandTitleWithVerifyIcon extends StatelessWidget {
  const SBrandTitleWithVerifyIcon({
    super.key,
    required this.title,
    this.maxLines=1,
    this.textAlign=TextAlign.center,
    this.brandTextSize=TextSizes.small,
    this.textColor,
    this.iconColor=SColors.primary,
  });

  final Color? textColor,iconColor;
  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SBrandTitleText(
            title: title,
            brandTextSize: brandTextSize,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
          ),
        ),
        SizedBox(width: SSize.xs,),
        Icon(Iconsax.verify5,color: iconColor,size: SSize.iconXs,),
      ],
    );
  }
}

