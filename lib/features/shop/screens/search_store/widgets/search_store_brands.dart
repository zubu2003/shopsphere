import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/appbar/SAppbar.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/features/shop/screens/brands/brand_products.dart';

import '../../../../../common/image_text/vertical_image_text.dart';
import '../../../../../common/texts/section_heading.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/image_string.dart';
import '../../../../../utils/constant/size.dart';
import '../../../../../utils/helper/helper_functions.dart';
import '../../../controllers/brand/brand_controller.dart';
import '../../../models/brand_model.dart';

class SSearchStoreBrand extends StatelessWidget {
  const SSearchStoreBrand({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);

    final brandController=Get.put(BrandController());

    return Obx(
        (){

          /// [State] - Loading
          if (brandController.isloading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// [State] - Empty
          if (brandController.allbrands.isEmpty) {
            return const Text('No Brands Found!');
          }

          /// [State] - Data Found
          List<BrandModel> brands = brandController.allbrands.take(10).toList();




          return Column(
            children: [
              SSectionHeading(title: 'Brands'),
              SizedBox(height: SSize.spaceBtwItems,),

              Wrap(
                spacing: SSize.spaceBtwItems,
                runSpacing: SSize.spaceBtwItems,
                children: brands.map((brand)=> SVerticalImageText(
                    title: brand.name,
                    image: brand.image,
                    textColor: dark? SColors.white : Colors.black, 
                    onTap: ()=>Get.to(BrandProductsScreen(title: brand.name, brand: brand)))
                ).toList()

              ),
            ],
          );
        }
    );
  }
}
