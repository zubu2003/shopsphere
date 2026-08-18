import 'package:flutter/material.dart';

class SProductPrice extends StatelessWidget {
  const SProductPrice({
    super.key,
    this.currencySign = '\$',
    required this.price,
    this.maxLines = 1,
    this.isLarge = true,
    this.lineThrough = false,
  });

  final String currencySign;
  final String price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      currencySign + price,
      maxLines: maxLines,
      style: (isLarge
          ? Theme.of(context).textTheme.titleLarge
          : Theme.of(context).textTheme.bodyMedium)
          ?.copyWith(
        decoration:
        lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }
}