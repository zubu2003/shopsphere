import 'package:flutter/material.dart';

import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';
import '../../utils/helper/helper_functions.dart';
// import '../../utils/helpers/helper_functions.dart';
// import '../../utils/constants/colors.dart';

class SCircularIcon extends StatelessWidget {
  const SCircularIcon({
    super.key,
    required this.icon,
    this.size = SSize.iconMd,
    this.backgroundColor,
    this.onPressed,
    this.height,
    this.width,
    this.color,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color, backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ??
            (dark
                ? SColors.dark.withValues(alpha: 0.9)
                : SColors.light.withValues(alpha: 0.9)),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
  }
}