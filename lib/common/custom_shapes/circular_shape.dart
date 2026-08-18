import 'package:flutter/material.dart';

import '../../utils/constant/colors.dart';

class SCircularShape extends StatelessWidget {
  const SCircularShape({
    super.key,
    this.height=300,
    this.width=300,
    this.radius=500,
    this.backgroundColor=SColors.white,
    this.padding,
    this.margin, this.child,
  });

  final double height, width, radius;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding, margin;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
