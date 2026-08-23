
import 'package:flutter/material.dart';
import 'package:shopsphere/common/shimmer/shimmer_effect.dart';

import '../../utils/constant/size.dart';

class SHorizontalProductShimmer extends StatelessWidget {
  const SHorizontalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: SSize.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(width: SSize.spaceBtwItems),
          itemCount: itemCount,
        itemBuilder: (context, index) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// Image
            SShimmerEffect(width: 120, height: 120),
            SizedBox(width: SSize.spaceBtwItems),


            /// Text
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SSize.spaceBtwItems),

                    /// Title
                    SShimmerEffect(width: 160, height: 15),
                    SizedBox(height: SSize.spaceBtwItems / 2),
                    /// Brand
                    SShimmerEffect(width: 110, height: 15)
                  ],

                ),

                Row(
                  children: [
                    SShimmerEffect(width: 40, height: 20),
                    SizedBox(width: SSize.spaceBtwSections),
                    SShimmerEffect(width: 40, height: 20)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
