import 'package:flutter/material.dart';

import '../../utils/constant/size.dart';

class SGridLayout extends StatelessWidget {
  const SGridLayout({
    super.key,
    required this.itemCount, this.mainAxisExtent=288, required this.itemBuilder,
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget Function(BuildContext context,int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount,
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: SSize.gridViewSpacing,
          crossAxisSpacing: SSize.gridViewSpacing,
          mainAxisExtent: mainAxisExtent,
        ),
        itemBuilder: itemBuilder,
    );
  }
}
