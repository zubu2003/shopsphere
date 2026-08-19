import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/common/shimmer/vertical_product_shimmer.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/features/shop/controllers/product/all_product_controller.dart';
import 'package:shopsphere/utils/helper/cloud_helper_functions.dart';

import '../../../../common/appbar/SAppbar.dart';
import '../../../../common/product/product_card/sortable_products.dart';
import '../../models/product_model.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key, this.futureMethod, this.query, required this.title});
  
  final String title;
  final Future<List<ProductModel>>? futureMethod;
  final Query? query;
  

  @override
  Widget build(BuildContext context) {
    final allproductController=Get.put(AllProductsController());

    return Scaffold(
      appBar: SAppBar(
        showLeading: true,
        title: Text("Popular Products",style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: SPadding.screenPadding,
          child: FutureBuilder(
              future: futureMethod ?? allproductController.fetchProductsByQuery(query),
              builder: (context,snapshot){

                const loader=SVerticalProductShimmer();
                final widget=SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                if(widget!=null)return widget;

                final products=snapshot.data!;
                return SSortableProducts(products: products,);
              },
          ),
        ),
      ),
    );
  }
}



