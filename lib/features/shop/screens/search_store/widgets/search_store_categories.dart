
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/appbar/SAppbar.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/features/shop/screens/all_products/all_products.dart';

import '../../../../../common/images/SRouundImage.dart';
import '../../../../../common/texts/section_heading.dart';
import '../../../../../utils/constant/image_string.dart';
import '../../../../../utils/constant/size.dart';
import '../../../controllers/category/category_controller.dart';
import '../../../models/category_model.dart';

class SearchStoreCategories extends StatelessWidget {
  const SearchStoreCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController= CategoryController.instance;
    return Obx(
        (){

          /// [State] - Loading
          if (categoryController.isCategoriesLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// [State] - Empty
          if (categoryController.allCategories.isEmpty) {
            return const Text('No Categories Found!');
          }

          /// [State] - Data Found
          List<CategoryModel> categories =categoryController.allCategories;


          return Column(
            children: [
              SSectionHeading(title: 'Categories',actionButton: false,),

              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {

                  final category=categories[index];

                  return ListTile(
                    onTap: ()=> Get.to(AllProductsScreen(title: category.name,
                      futureMethod:categoryController.getCategoryProducts(categoryId: category.id) ,)
                    ),
                    contentPadding: EdgeInsets.zero,
                    leading: SRoundedImage(
                      imageUrl: category.image,
                      borderRadius: 0,
                      width: SSize.iconLg,
                      height: SSize.iconLg,
                      isNetworkImage: true,
                    ),
                    title: Text(category.name),
                  );
                },
              ),
            ],
          );
        }
    );
  }
}
