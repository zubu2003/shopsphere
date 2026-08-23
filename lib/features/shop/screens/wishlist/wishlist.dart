import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/bottom_navigation.dart';
import 'package:shopsphere/common/appbar/SAppbar.dart';
import 'package:shopsphere/common/icon/circular_icon.dart';
import 'package:shopsphere/common/layout/grid_layout.dart';
import 'package:shopsphere/common/loaders/animation_loader.dart';
import 'package:shopsphere/common/product/product_card/product_card_vertical.dart';
import 'package:shopsphere/features/shop/controllers/product/favourite_controller.dart';
import 'package:shopsphere/features/shop/models/product_model.dart';
import 'package:shopsphere/utils/constant/image_string.dart';
import 'package:shopsphere/utils/constant/size.dart';

import '../../../../common/shimmer/vertical_product_shimmer.dart';
import '../../../../utils/helper/cloud_helper_functions.dart';

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
          child: Obx(
              ()=> FutureBuilder(

                future: FavouriteController.instance.getFavouriteProducts(),

                builder: (context,snapshot){

                  final nothingFound = SAnimationLoader(
                      text: 'Wishlist is Empty ... ',
                    animation:SImages.pencilAnimation ,
                    showActionButton: true,
                    actionText: "Let's add some",
                    onActionPressed: ()=> NavigationController.instance.selectedIndex.value=0,
                  );
                  const loader = SVerticalProductShimmer(itemCount: 6);

                  /// Handle Empty Data, Loading And Error
                  final widget = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader,nothingFound: nothingFound);
                  if (widget != null) return widget;

                  /// Products Found
                  final products=snapshot.data!;

                  return SGridLayout(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return SProductCardVertical(product: products[index],);
                    },
                  );
                }),
          )
        ),
      ),
    );
  }
}
