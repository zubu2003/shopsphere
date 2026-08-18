
import 'package:flutter/material.dart';

class SProductTitle extends StatelessWidget {
  const SProductTitle({
    super.key,
    required this.title,
    this.maxLine=2,
    this.textAlign=TextAlign.start,
    this.smallLine=false,
  });

  final String title;
  final bool smallLine;
  final int maxLine;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:smallLine? Theme.of(context).textTheme.labelLarge :Theme.of(context).textTheme.titleSmall ,
      maxLines: maxLine,
      textAlign: textAlign,
    );
  }
}