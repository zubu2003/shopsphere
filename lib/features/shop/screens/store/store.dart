import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/common/texts/section_heading.dart';
import 'package:shopsphere/features/shop/controllers/brand/brand_controller.dart';
import 'package:shopsphere/features/shop/controllers/category/category_controller.dart';
import 'package:shopsphere/features/shop/screens/brands/brands.dart';
import 'package:shopsphere/features/shop/screens/store/widget/category_tab.dart';
import 'package:shopsphere/features/shop/screens/store/widget/store_primary_header.dart';

import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../../../common/appbar/store_tab_Bar.dart';
import '../../../../common/brand/brand_card.dart';
import '../../../../common/shimmer/brands_shimmer.dart';
import '../brands/brand_products.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=CategoryController.instance;
    final brandcontroller=Get.put(BrandController());

    final dark = SHelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: controller.feautredCategories.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 340,
                pinned: true,
                floating: false,

                ///showing all brands
                flexibleSpace: SingleChildScrollView(
                  child: Column(
                    children: [
                      //primary header
                      SStorePrimaryHeader(),
                      SizedBox(
                        height: SSize.spaceBtwItems,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: SSize.defaultSpace),
                        child: Column(
                          children: [
                            //brand heading
                            SSectionHeading(
                              title: "Brands",
                              onPressed: () =>Get.to(()=>BrandScreen()),
                            ),

                            //brand card
                            SizedBox(
                              height: SSize.brandCardHeight,
                              child: Obx(
                                (){
                                  ///[Loading state]
                                  if(brandcontroller.isloading.value) {
                                    return SBrandsShimmer();
                                  }

                                  ///[Empty state]
                                  if(brandcontroller.featurebrands.isEmpty) {
                                    return Text('Brands Not Found!');
                                  }

                                  ///[DatafoundState]
                                  return ListView.separated(
                                    itemCount: brandcontroller.featurebrands.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          width: SSize.spaceBtwItems,
                                        ),
                                    itemBuilder: (context, index) {
                                      final brand=brandcontroller.featurebrands[index];
                                      return SizedBox(
                                          width: SSize.brandCardWidth,
                                          child: SBrandCard(brand: brand,
                                              onTap:() => Get.to(() => BrandProductsScreen(
                                            title: brand.name,
                                            brand: brand,
                                            )),
                                          ));
                                    },
                                  );
                                }
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //tab bar
                bottom: STabBar(
                  tabs: controller.feautredCategories.map((category)=> Tab(
                    child: Text(category.name),
                  ),).toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: controller.feautredCategories.map((category)=> SCategoryTab(category: category,)).toList(),
          ),
        ),
      ),
    );
  }
}

