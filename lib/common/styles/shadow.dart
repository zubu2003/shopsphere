import 'package:flutter/material.dart';

import '../../utils/constant/colors.dart';

class SShadow{
  SShadow._();

  static List<BoxShadow> searchBoxShadow=[
    BoxShadow(
        color: SColors.black.withValues(alpha: 0.2),
        spreadRadius: 2.0,
        blurRadius: 4.0
    ),
  ];

  static List<BoxShadow> productBoxShadow=[
    BoxShadow(
    color: SColors.darkerGrey.withValues(alpha: 0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: Offset(0,3),
  ),
  ];

}