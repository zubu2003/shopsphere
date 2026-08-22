import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/features/shop/models/category_model.dart';
import 'package:shopsphere/features/shop/models/product_model.dart';
import 'package:shopsphere/features/shop/screens/all_products/all_products.dart';
import 'package:shopsphere/features/shop/screens/store/widget/category_brands.dart';
import '../../../../../common/brand/brand_showcase.dart';
import '../../../../../common/layout/grid_layout.dart';
import '../../../../../common/product/product_card/product_card_vertical.dart';
import '../../../../../common/shimmer/vertical_product_shimmer.dart';
import '../../../../../common/texts/section_heading.dart';
import '../../../../../utils/constant/image_string.dart';
import '../../../../../utils/constant/size.dart';
import '../../../../../utils/helper/cloud_helper_functions.dart';
import '../../../controllers/category/category_controller.dart';

class SCategoryTab extends StatelessWidget {
  const SCategoryTab({
    super.key, required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller=CategoryController.instance;

    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SSize.defaultSpace),
          child: Column(
            children: [

              ///need to update here

              CategoryBrands(category: category,),


              SizedBox(height: SSize.spaceBtwItems,),
              SSectionHeading(title: "You might also like",
                onPressed: () =>
                    Get.to(() => AllProductsScreen(
                      title: category.name,
                      futureMethod: controller.getCategoryProducts(categoryId: category.id,limit: -1),
                    )),),
              /// Grid Layout Products
              FutureBuilder<List<ProductModel>>(
                future: controller.getCategoryProducts(
                  categoryId: category.id,
                ),
                builder: (context, snapshot) {
                  /// Handle Error, Loader and Empty States
                  const loader = SVerticalProductShimmer(itemCount: 4,);

                  final widget = SCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                  );

                  if (widget != null) return widget;

                  /// Data Found
                  final List<ProductModel> products = snapshot.data!;

                  return SGridLayout(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final ProductModel product = products[index];

                      return SProductCardVertical(
                        product: product,
                      );
                    },
                  );
                },
              ),

              SizedBox(height: SSize.spaceBtwSections,),
            ],
          ),
        ),
      ],
    );
  }
}