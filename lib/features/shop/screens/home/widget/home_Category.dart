import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/common/shimmer/category_shimmer.dart';
import 'package:shopsphere/features/shop/controllers/category/category_controller.dart';
import 'package:shopsphere/features/shop/models/category_model.dart';
import 'package:shopsphere/utils/constant/image_string.dart';

import '../../../../../common/image_text/vertical_image_text.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/text_strings.dart';
import '../../sub_category/subcategory.dart';
class SHomeCategories extends StatelessWidget {
  const SHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(CategoryController());

    return Padding(
      padding: EdgeInsets.fromLTRB(SSize.spaceBtwSections,0,0,0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            STexts.popularCategories,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: SColors.white),
          ),
          SizedBox(height: SSize.spaceBtwItems),

          //category listview
          Obx(
            (){
              final categories=controller.allCategories
                  .where((category) => category.parentId == "")
                  .toList();

              ///[LoadinState]
              if(controller.isCategoriesLoading.value){
                return SCategoryShimmer();
              }

              if(categories.isEmpty){
                return Text('Category is not found');
              }


              ///[Datafound]
              return  SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: SSize.spaceBtwItems,),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {

                    CategoryModel category=categories[index];

                    return SVerticalImageText(
                      title: category.name,
                      image: category.image,
                      textColor: SColors.white,
                      onTap: () =>Get.to(()=>SubcategoryScreen(category: category,)),
                    );
                  },
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}


