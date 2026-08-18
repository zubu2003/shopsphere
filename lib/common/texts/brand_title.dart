import 'package:flutter/material.dart';

enum TextSizes { small, medium, large }

class SBrandTitleText extends StatelessWidget {
  const SBrandTitleText({
    super.key,
    this.color,
    required this.title,
    this.maxLines = 1,
    this.textAlign,
    this.brandTextSize = TextSizes.small,
  });

  final Color? color;
  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: (brandTextSize == TextSizes.small)
          ? Theme.of(context).textTheme.labelMedium!.copyWith(color: color)
          : (brandTextSize == TextSizes.medium)? Theme.of(context).textTheme.bodyLarge?.copyWith(color: color)
          : (brandTextSize == TextSizes.large)? Theme.of(context).textTheme.titleLarge?.copyWith(color: color)
          : Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
    );
  }
}