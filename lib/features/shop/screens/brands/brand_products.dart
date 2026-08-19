import 'package:flutter/material.dart';
import 'package:shopsphere/common/brand/brand_card.dart';
import 'package:shopsphere/common/product/product_card/sortable_products.dart';
import 'package:shopsphere/common/shimmer/vertical_product_shimmer.dart';
import 'package:shopsphere/features/shop/controllers/brand/brand_controller.dart';
import 'package:shopsphere/features/shop/models/brand_model.dart';
import 'package:shopsphere/utils/helper/cloud_helper_functions.dart';

import '../../../../common/appbar/SAppbar.dart';
import '../../../../common/styles/padding.dart';
import '../../../../utils/constant/size.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key, required this.title, required this.brand});

  final String title;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final brandController=BrandController.instance;
    return Scaffold(
      appBar: SAppBar(
        showLeading: true,
        title: Text(title,style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: Column(
            children: [
              SBrandCard(brand: brand,),
              SizedBox(height: SSize.spaceBtwSections,),

              //list of brands
             FutureBuilder(
                 future: brandController.getBrandProducts(brand.id),
                 builder: (context,snapshot){

                   ///handle loading error state
                   const loader=SVerticalProductShimmer();
                   Widget? widget =SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                   if(widget!=null)return widget;

                   ///data found
                   final products=snapshot.data!;
                   return  SSortableProducts(products: products,);

                 }
             )

            ],
          ),
        ),
      ),
    );
  }
}
