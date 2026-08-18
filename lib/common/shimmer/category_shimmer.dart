import 'package:flutter/material.dart';
import 'package:shopsphere/common/shimmer/shimmer_effect.dart';

import '../../utils/constant/size.dart';

class SCategoryShimmer extends StatelessWidget {
  const SCategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: SSize.spaceBtwItems),
        itemBuilder: (context, index) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              SShimmerEffect(width: 55, height: 55, radius: 55),
              SizedBox(height: SSize.spaceBtwItems / 2),

              /// Text
              SShimmerEffect(width: 55, height: 8)
            ],
          );
        },
      ),
    );
  }
}
