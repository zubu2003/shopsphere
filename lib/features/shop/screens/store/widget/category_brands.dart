import 'package:flutter/material.dart';
import 'package:shopsphere/common/brand/brand_showcase.dart';
import 'package:shopsphere/features/shop/controllers/brand/brand_controller.dart';
import 'package:shopsphere/features/shop/models/category_model.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/helper/cloud_helper_functions.dart';

import '../../../../../common/shimmer/boxes_shimmer.dart';
import '../../../../../common/shimmer/list_tile_shimmer.dart';
import '../../../../../utils/constant/image_string.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller=BrandController.instance;

    return FutureBuilder(
      future: controller.getBrandsForCategory(category.id),
      builder: (context, snapshot) {

        const loader=Column(
          children: [
            SListTileShimmer(),
            SizedBox(height: SSize.spaceBtwItems,),
            SBoxesShimmer(),
            SizedBox(height: SSize.spaceBtwItems,),
          ],
        );

        final widget = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
        if(widget !=null)return widget;

        final brands=snapshot.data!;

        return ListView.builder(
            itemCount: brands.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){
              final brand=brands[index];
              return FutureBuilder(
                  future: controller.getBrandProducts(brand.id,limit:3 ),
                  builder: (context, snapshot) {

                    // Handle Loader, No Records, Error
                    final widget = SCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                    );

                    if (widget != null) return widget;

                    // Products Found
                    final products = snapshot.data!;

                    return SbrandShowCase(
                      brand: brand,
                      images: products.map((product) => product.thumbnail).toList(),
                    );

                  },
              );
          }
        );




      }
    );
  }
}
