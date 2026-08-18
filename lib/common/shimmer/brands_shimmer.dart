
import 'package:flutter/material.dart';
import 'package:shopsphere/common/shimmer/shimmer_effect.dart';


import '../../utils/constant/size.dart';

class SBrandsShimmer extends StatelessWidget {
  const SBrandsShimmer({super.key,this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(width: SSize.spaceBtwItems),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      itemBuilder: (context, index) => SShimmerEffect(width: SSize.brandCardWidth, height: SSize.brandCardHeight),
    );
  }
}
