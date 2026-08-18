
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/features/shop/controllers/homeController.dart';
import 'package:shopsphere/features/shop/controllers/product/product_controller.dart';
import 'package:shopsphere/features/shop/models/product_model.dart';
import 'package:shopsphere/features/shop/screens/all_products/all_products.dart';
import 'package:shopsphere/features/shop/screens/home/widget/HomeAppBar.dart';
import 'package:shopsphere/features/shop/screens/home/widget/PromoSlider.dart';
import 'package:shopsphere/features/shop/screens/home/widget/home_Category.dart';
import 'package:shopsphere/common/custom_shapes/primary_header.dart';
import 'package:shopsphere/utils/constant/image_string.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';
import '../../../../common/layout/grid_layout.dart';
import '../../../../common/product/product_card/product_card_vertical.dart';
import '../../../../common/textfield/search_bar.dart';
import '../../../../common/texts/section_heading.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller= Get.put(Homecontroller());
    final productController= Get.put(ProductController());

    final dark = SHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //upper part
            Stack(
              children: [
                SizedBox(height: SSize.homePrimaryHeaderHeight + 10),
        
                //primary header container
                SHomePrimaryHeader(
                  height: SSize.homePrimaryHeaderHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SHomeAppBar(dark: dark),
                      SizedBox(height: SSize.spaceBtwSections,),
                //home categories
                      SHomeCategories(),
                    ],
                  ),
                ),
                //search box container
                SSearchBar(),
              ],
            ),
            //-----------------------------------
        
            //lower part
            Padding(
              padding: const EdgeInsets.all(SSize.defaultSpace),
              child: Column(
                children: [
                    ///banner
                  SPromoSlider(),
        
                    ///section heading
                  SSectionHeading(title: 'Popular Products',onPressed: ()=>Get.to(()=>AllProductsScreen()),),
                    SizedBox(height: SSize.spaceBtwItems,),
                    ///vertical product card

                  Obx(
                  () {

                    if(productController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if(productController.featuredProducts.isEmpty) {
                      return Center(child: Text('Products Not Found!'));
                    }

                    return SGridLayout(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        ProductModel product= productController.featuredProducts[index];
                        return SProductCardVertical(product: product,);
                      },
                    );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}









