import 'package:flutter/material.dart';
import 'package:shopsphere/common/brand/brand_card.dart';
import 'package:shopsphere/common/product/product_card/sortable_products.dart';
import 'package:shopsphere/features/shop/models/brand_model.dart';

import '../../../../common/appbar/SAppbar.dart';
import '../../../../common/styles/padding.dart';
import '../../../../utils/constant/size.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        showLeading: true,
        title: Text("Bata",style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: Column(
            children: [
              SBrandCard(brand: BrandModel.empty(),),
              SizedBox(height: SSize.spaceBtwSections,),

              //list of brands
              SSortableProducts(products: [],),

            ],
          ),
        ),
      ),
    );
  }
}
