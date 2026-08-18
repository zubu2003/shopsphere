import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/bottom_navigation.dart';
import 'package:shopsphere/common/appbar/SAppbar.dart';
import 'package:shopsphere/common/icon/circular_icon.dart';
import 'package:shopsphere/common/layout/grid_layout.dart';
import 'package:shopsphere/common/product/product_card/product_card_vertical.dart';
import 'package:shopsphere/features/shop/models/product_model.dart';
import 'package:shopsphere/utils/constant/size.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        title: Text(
          "Wishlist",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          SCircularIcon(
            icon: Iconsax.add,
            onPressed: () =>
                NavigationController.instance.selectedIndex.value = 0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSize.defaultSpace),
          child: SGridLayout(
            itemCount: 10,
            itemBuilder: (context, index) {
              return SProductCardVertical(product: ProductModel.empty(),);
            },
          ),
        ),
      ),
    );
  }
}
