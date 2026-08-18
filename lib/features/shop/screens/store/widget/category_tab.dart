import 'package:flutter/material.dart';
import 'package:shopsphere/features/shop/models/product_model.dart';
import '../../../../../common/brand/brand_showcase.dart';
import '../../../../../common/layout/grid_layout.dart';
import '../../../../../common/product/product_card/product_card_vertical.dart';
import '../../../../../common/texts/section_heading.dart';
import '../../../../../utils/constant/image_string.dart';
import '../../../../../utils/constant/size.dart';

class SCategoryTab extends StatelessWidget {
  const SCategoryTab({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SSize.defaultSpace),
          child: Column(
            children: [

              ///need to update here

              SbrandShowCase(
                images: [
                  SImages.productImage47,
                  SImages.productImage48,
                  SImages.productImage22,
                ],
              ),
              SbrandShowCase(
                images: [
                  SImages.productImage47,
                  SImages.productImage48,
                  SImages.productImage22,
                ],
              ),
              SizedBox(height: SSize.spaceBtwItems,),
              SSectionHeading(title: "You might also like"),
              SGridLayout(
                  itemCount: 4,
                  itemBuilder: (context,index){

                    ///need to update this line
                    ///
                    return SProductCardVertical(product: ProductModel.empty(),);
                  }
              ),
              SizedBox(height: SSize.spaceBtwSections,),
            ],
          ),
        ),
      ],
    );
  }
}