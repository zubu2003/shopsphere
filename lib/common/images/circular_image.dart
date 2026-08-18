import 'package:flutter/material.dart';

import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';
import '../../utils/helper/helper_functions.dart';

class SCircularImage extends StatelessWidget {
  const SCircularImage(
      {super.key,
        this.width = 56,
        this.height = 56,
        this.overlayColor,
        this.backgroundColor,
        required this.image,
        this.fit = BoxFit.cover,
        this.padding = SSize.sm,
        this.isNetworkImage = false,
        this.showBorder = true,
        this.borderColor = SColors.primary,
        this.borderWidth = 1.0});

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;
  final bool showBorder;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);

    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: backgroundColor ?? (dark ? SColors.dark : SColors.light),
          borderRadius: BorderRadius.circular(100),
          border: showBorder ? Border.all(color: borderColor, width: borderWidth) : null),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image(
          image: isNetworkImage? NetworkImage(image)
              : AssetImage(image) as ImageProvider,
              fit: fit,
        ),


        /*child: isNetworkImage
            ? CachedNetworkImage(
            fit: fit,
            color: overlayColor,
            progressIndicatorBuilder: (context, url, progress) => UShimmerEffect(width: 55, height: 55),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageUrl: image)
            : Image(fit: fit, image: AssetImage(image)),*/
      ),
    );
  }
}