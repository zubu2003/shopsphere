import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/common/brand/brand_card.dart';
import 'package:shopsphere/common/layout/grid_layout.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/common/texts/section_heading.dart';
import 'package:shopsphere/features/shop/controllers/brand/brand_controller.dart';
import 'package:shopsphere/features/shop/models/brand_model.dart';
import 'package:shopsphere/features/shop/screens/brands/brand_products.dart';
import 'package:shopsphere/utils/constant/size.dart';

import '../../../../common/appbar/SAppbar.dart';
import '../../../../common/shimmer/brands_shimmer.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final brandController=BrandController.instance;

    return Scaffold(
      appBar: SAppBar(
        showLeading: true,
        title: Text("Brand",style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: Column(
            children: [
              SSectionHeading(title: "Brands",actionButton: false,),
              SizedBox(height: SSize.spaceBtwItems,),

              //list of brands
              Obx(
                (){

                  ///[Loading state]
                  if(brandController.isloading.value) {
                    return  SBrandsShimmer();
                  }

                  ///[Empty state]
                  if(brandController.allbrands.isEmpty) {
                    return Text('Brands Not Found!');
                  }
                  ///[DatafoundState]
                  return SGridLayout(
                      mainAxisExtent: 80,
                      itemCount: brandController.allbrands.length,
                      itemBuilder: (context, index) {
                        final brand = brandController.allbrands[index];
                        return SBrandCard(
                          brand: brand,
                          onTap: () => Get.to(() => BrandProductsScreen(
                            title: brand.name,
                            brand: brand,
                          )),
                        );
                      }
                  );
                }
              ),


            ],
          ),
        ),
      ),
    );
  }
}
