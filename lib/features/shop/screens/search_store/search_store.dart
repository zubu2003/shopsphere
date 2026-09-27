import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/appbar/SAppbar.dart';
import 'package:shopsphere/common/layout/grid_layout.dart';
import 'package:shopsphere/common/product/product_card/product_card_vertical.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/features/shop/controllers/product/product_controller.dart';
import 'package:shopsphere/features/shop/screens/search_store/widgets/search_store_brands.dart';
import 'package:shopsphere/features/shop/screens/search_store/widgets/search_store_categories.dart';

import '../../../../utils/constant/size.dart';
import '../../../../utils/helper/cloud_helper_functions.dart';

class SearchStoreScreen extends StatelessWidget {
  const SearchStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {

    RxString searchText=''.obs;

    return Scaffold(
      appBar: SAppBar(
        showLeading: true,
        title: Text("Search",style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child:Padding(padding: SPadding.screenPadding,
          child: Column(
            children: [
              /// Search Field
              Hero(
                tag: 'search_animation',
                child: Material(
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.search_normal),
                      hintText: 'Search in store',
                    ),
                    onChanged: (value)=>searchText.value=value,
                  ),
                ),
              ),

              SizedBox(height: SSize.spaceBtwSections),

             Obx(
                 (){
                   if(searchText.value.isEmpty){
                     return Column(
                       children: [
                         /// Brands
                         SSearchStoreBrand(),

                         SizedBox(height: SSize.spaceBtwItems,),


                         /// Categories
                         SearchStoreCategories(),
                       ],
                     );
                   }
                   
                   return FutureBuilder(
                       future: ProductController.instance.getAllProduct() ,
                       builder: (context,snapshot){

                         /// Handle Loading, Error, Empty
                         final widget = SCloudHelperFunctions.checkMultiRecordState(
                           snapshot: snapshot,
                         );

                         if (widget != null) return widget;

                         /// Data Found - Products Found
                         final products = snapshot.data!;

                         ///filter product list
                         final filterProducts= products.where((product)=> product.title.toLowerCase().contains(searchText.value)).toList();

                         if(filterProducts.isEmpty) return Text("No products found");


                         return SGridLayout(
                             itemCount: filterProducts.length,
                             itemBuilder: (context,index){
                               final product=filterProducts[index];
                               return SProductCardVertical(product: product);
                             }
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

