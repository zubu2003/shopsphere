import 'package:flutter/material.dart';

import '../../../../../utils/constant/text_strings.dart';
class SLoginHeader extends StatelessWidget {
  const SLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(STexts.loginTitle,style: Theme.of(context).textTheme.headlineMedium,),
        Text(STexts.loginSubTitle,style: Theme.of(context).textTheme.bodyMedium,),
      ],
    );
  }
}