import 'package:flutter/material.dart';
import 'package:shopsphere/common/custom_shapes/rounded_edges_container.dart';
import 'package:shopsphere/utils/constant/size.dart';

import 'circular_shape.dart';
import '../../utils/constant/colors.dart';
class SHomePrimaryHeader extends StatelessWidget {
  const SHomePrimaryHeader({
    super.key, required this.child, required this.height,
  });

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SRoundedEdgesContainer(
      child: Container(
        height: height,
        color: SColors.primary,
        child: Stack(
          children: [
      
            //circular
            Positioned(
              top: -150,
              right: -160,
              child: SCircularShape(
                height:SSize.homePrimaryHeaderHeight,
                width: SSize.homePrimaryHeaderHeight,
                backgroundColor: SColors.white.withValues(alpha: 0.1),
                radius: 500,
      
              ),
            ),
            //circular
            Positioned(
              top: 50,
              right: -250,
              child: SCircularShape(
                height:SSize.homePrimaryHeaderHeight,
                width: SSize.homePrimaryHeaderHeight,
                backgroundColor: SColors.white.withValues(alpha: 0.1),
                radius: 500,
              ),
            ),
      
            //child widget
            child,
          ],
        ),
      ),
    );
  }
}



