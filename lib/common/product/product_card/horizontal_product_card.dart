import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/texts/brand_title_with_verify_icon.dart';
import 'package:shopsphere/common/texts/product_price.dart';
import 'package:shopsphere/common/texts/product_title.dart';
import 'package:shopsphere/common/widgets/button/add_to_cart.dart';
import 'package:shopsphere/features/shop/models/product_model.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../../features/shop/controllers/product/product_controller.dart';
import '../../../features/shop/screens/product_details/product_details.dart';
import '../../custom_shapes/rounded_container.dart';
import '../../icon/circular_icon.dart';
import '../../images/SRouundImage.dart';
import '../../../utils/constant/colors.dart';
import '../../../utils/constant/image_string.dart';
import '../../../utils/constant/size.dart';
import '../favourite/favourite_icon.dart';

class SProductCardHorizontal extends StatelessWidget {
  const SProductCardHorizontal({
    super.key, required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {

    final productController=ProductController.instance;
    String? salePercentage= productController.calculateSalePercentage(product.price, product.salePrice);


    final dark=SHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: ()=>Get.to(()=>ProductDetailsScreen(product: product,)),
      child: Container(
        width: 310,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SSize.productImageRadius),
          color: dark? SColors.darkGrey: SColors.light,
        ),
        child: Row(
          children: [
            //left portion
            SRoundedContainer(
              height: 120,
              padding: EdgeInsets.all(SSize.sm),
              backgroundColor: dark? SColors.dark: SColors.light,
              child: Stack(
                children: [
                  SizedBox(
                    height:120,
                    width: 120,
                    child: SRoundedImage(imageUrl: product.thumbnail,isNetworkImage: true,),
                  ),
                  ///Discount Tag
                  if(salePercentage!=null)
                  Positioned(
                    top: 12,
                    child: SRoundedContainer(
                      radius: SSize.sm,
                      backgroundColor: SColors.yellow.withValues(alpha: 0.8),
                      padding: EdgeInsets.symmetric(horizontal: SSize.sm,vertical: SSize.xs),
                      child: Text(salePercentage,style: Theme.of(context).textTheme.labelMedium!.apply(color: SColors.dark),),
                    ),
                  ),


                  //fav tag
                  Positioned(
                      right: 0,
                      top: 0,
                      child: SFavouriteIcon(productId: product.id,),
                  ),
                ],
              ) ,
            ),

            //right portion
            SizedBox(
              width: 172.0,
              child: Padding(
                padding:EdgeInsetsGeometry.only(left: SSize.sm,top: SSize.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //product name and brand
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SProductTitle(title: product.title,smallLine: true,),
                        SizedBox(height: SSize.spaceBtwItems/2,),

                        //brand
                        SBrandTitleWithVerifyIcon(title: product.brand!.name,),
                      ],
                    ),
                    Spacer(),
                    //price and add button
                    Row(
                      children: [
                        SProductPrice(price: productController.getProductPrice(product),),
                        Spacer(),

                        //Add button
                        ProductAddToCartButton(product: product),
                      ],
                    ),



                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
