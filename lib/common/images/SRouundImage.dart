import 'package:flutter/material.dart';

import '../../utils/constant/size.dart';

class SRoundedImage extends StatelessWidget {
  const SRoundedImage({
    super.key,
    required this.imageUrl,
    this.height, this.width,
    this.applyImageRadius=true,
    this.border,
    this.backgroundColor,
    this.padding,
    this.isNetworkImage=false,
    this.onTap,
    this.borderRadius=SSize.md,
  });
  final String imageUrl;
  final double? height,width;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onTap;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        child: ClipRRect(
          borderRadius:applyImageRadius? BorderRadius.circular(borderRadius!): BorderRadius.zero,
          child: Image(
            image: isNetworkImage
                ? NetworkImage(imageUrl)
                : AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}