import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/custom_shapes/rounded_container.dart';
import 'package:shopsphere/common/icon/circular_icon.dart';
import 'package:shopsphere/common/images/SRouundImage.dart';
import 'package:shopsphere/common/widgets/button/add_to_cart.dart';
import 'package:shopsphere/features/shop/controllers/product/product_controller.dart';
import 'package:shopsphere/features/shop/models/product_model.dart';
import 'package:shopsphere/features/shop/screens/product_details/product_details.dart';
import 'package:shopsphere/utils/constant/colors.dart';
import 'package:shopsphere/utils/constant/image_string.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../../utils/constant/size.dart';
import '../../styles/shadow.dart';
import '../../texts/brand_title_with_verify_icon.dart';
import '../../texts/product_price.dart';
import '../../texts/product_title.dart';
import '../favourite/favourite_icon.dart';

class SProductCardVertical extends StatelessWidget {
  const SProductCardVertical({
    super.key, required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {

    final dark=SHelperFunctions.isDarkMode(context);
    final productController=ProductController.instance;
    String? salePercentage= productController.calculateSalePercentage(product.price, product.salePrice);

    return GestureDetector(
      onTap: ()=>Get.to(()=>ProductDetailsScreen(product: product,)),
      child: Container(
        width: 180,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: SShadow.productBoxShadow,
          borderRadius: BorderRadius.circular(SSize.productImageRadius),
        ),
        child: Column(
          children: [
            //thumbnail, fav tag , discount tag
            SRoundedContainer(
              height: 175,
              padding: EdgeInsets.all(SSize.sm),
              backgroundColor: dark? SColors.dark : SColors.white,
              child: Stack(
                children: [
                  //thumbnail
                  Center(child: SRoundedImage(imageUrl: product.thumbnail,isNetworkImage: true,)),
                  //discount tag
                  if(salePercentage!=null)
                  Positioned(
                    top: 12,
                    child: SRoundedContainer(
                      radius: SSize.sm,
                      backgroundColor: SColors.yellow.withValues(alpha: 0.8),
                      padding: EdgeInsets.symmetric(horizontal: SSize.sm,vertical: SSize.xs),
                      child: Text("20%",style: Theme.of(context).textTheme.labelMedium!.apply(color: SColors.dark),),
                    ),
                  ),

                  //fav tag
                  Positioned(
                    right: 0,
                    top: 0,
                    child:SFavouriteIcon(productId: product.id),
                  ),
                  SizedBox(height: SSize.spaceBtwItems,),

                ],
                  //lower part

              ),

            ),
            SizedBox(height: SSize.spaceBtwItems/2,),

            Padding(
              padding: const EdgeInsets.only(left: SSize.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SProductTitle(
                    title: product.title,
                    smallLine: false,
                  ),
                  SizedBox(height: SSize.spaceBtwItems /2 ,),
                  //brand name and icon
                  SBrandTitleWithVerifyIcon(title: product.brand!.name,),


                ],
              ),
            ),
            Spacer(),
            //product price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: SSize.sm),
                  child: SProductPrice(price: productController.getProductPrice(product),),
                ),

                // Add button
                ProductAddToCartButton(product : product)

              ],
            ),

          ],
        ),
      ),
    );
  }
}






