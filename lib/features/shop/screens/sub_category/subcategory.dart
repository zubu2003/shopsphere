import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/common/shimmer/horizontal_product_shimmer.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/common/texts/section_heading.dart';
import 'package:shopsphere/common/product/product_card/horizontal_product_card.dart';
import 'package:shopsphere/features/shop/controllers/category/category_controller.dart';
import 'package:shopsphere/features/shop/screens/all_products/all_products.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/helper/cloud_helper_functions.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../../../common/appbar/SAppbar.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';

class SubcategoryScreen extends StatelessWidget {
  const SubcategoryScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller=CategoryController.instance;
    final dark=SHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: SAppBar(
        title: Text(category.name,style: Theme.of(context).textTheme.headlineSmall,),
        showLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: SPadding.screenPadding,
          child: Column(
            children: [

              FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context,snapshot){

                    const loader=SHorizontalProductShimmer();
                    final widget=SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                    if(widget!=null )return widget;

                    /// Data found
                    final subcategories=snapshot.data!;

                    return ListView.builder(
                      shrinkWrap: true,
                        itemCount: subcategories.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder:(context,index){

                          final subcategory=subcategories[index];

                         //fetch product for each category
                         return FutureBuilder(
                             future: controller.getCategoryProducts(categoryId: subcategory.id),
                             builder: (context,snapshot){

                               const loader=SHorizontalProductShimmer();
                               final widget=SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                               if(widget!=null )return widget;

                               /// Product found
                               List<ProductModel> products=snapshot.data!;
                               return Column(
                                 children: [
                                   //sub category
                                   SSectionHeading(title: subcategory.name,onPressed: ()=>Get.to(AllProductsScreen(
                                     title: subcategory.name,
                                     futureMethod: controller.getCategoryProducts(categoryId: subcategory.id,limit: -1),
                                   )),
                                   ),
                                   SizedBox(height: SSize.spaceBtwItems/2,),

                                   //horizontal product card
                                   SizedBox(
                                     height: 120,
                                     child:ListView.separated(
                                       scrollDirection: Axis.horizontal,
                                       itemCount: products.length,
                                       separatorBuilder: (context,index)=>SizedBox(width: SSize.spaceBtwItems,),
                                       itemBuilder: (context,index){

                                         final product=products[index];

                                         return SProductCardHorizontal(product: product,);
                                       }
                                     ),
                                   ),
                                 ],
                               );
                             },
                         );
                        }
                    );
                  },
              )




            ],
          ),
        ),
      ),
    );
  }
}



