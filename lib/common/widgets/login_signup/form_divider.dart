import 'package:flutter/material.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

class SFormDivider extends StatelessWidget {
  final String title;
  const SFormDivider({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Expanded(child: Divider(indent: 30,endIndent: 6,color: dark? Colors.white: Colors.black,)),
        Text(title,style: Theme.of(context).textTheme.labelMedium,),
        Expanded(child: Divider(indent: 6,endIndent: 30,color: dark? Colors.white: Colors.black,)),
      ],
    );
  }
}