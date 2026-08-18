import 'package:flutter/material.dart';
import 'package:shopsphere/common/styles/padding.dart';

import '../../../../common/appbar/SAppbar.dart';
import '../../../../common/product/product_card/sortable_products.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        showLeading: true,
        title: Text("Popular Products",style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: SPadding.screenPadding,
          child: SSortableProducts(),
        ),
      ),
    );
  }
}



