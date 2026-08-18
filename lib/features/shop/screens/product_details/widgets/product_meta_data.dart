import 'package:flutter/material.dart';
import 'package:shopsphere/features/shop/controllers/product/product_controller.dart';

import '../../../../../common/custom_shapes/rounded_container.dart';
import '../../../../../common/images/circular_image.dart';
import '../../../../../common/texts/brand_title_with_verify_icon.dart';
import '../../../../../common/texts/product_price.dart';
import '../../../../../common/texts/product_title.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/enums.dart';
import '../../../../../utils/constant/image_string.dart';
import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/text_strings.dart';
import '../../../models/product_model.dart';
class SProductMetaData extends StatelessWidget {
  const SProductMetaData({
    super.key, required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {

    final productController=ProductController.instance;
    final salePercentage = productController.calculateSalePercentage(product.price, product.salePrice);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [

            ///sale tag
            if(salePercentage!=null)...[
              SRoundedContainer(
                radius: SSize.sm,
                backgroundColor: SColors.yellow.withValues(alpha: 0.8),
                padding: EdgeInsets.symmetric(horizontal: SSize.sm,vertical: SSize.xs),
                child: Text('$salePercentage%',style: Theme.of(context).textTheme.labelMedium!.apply(color: SColors.dark),),
              ),
              SizedBox(width: SSize.spaceBtwItems,),
            ],

            //price
            if(product.productType == ProductType.single.toString() && product.salePrice > 0)...[
              SProductPrice(price:product.price.toStringAsFixed(0),lineThrough: true,isLarge: false,),
              SizedBox(width: SSize.spaceBtwItems,),
            ],

            ///sale price
            SProductPrice(price: productController.getProductPrice(product),isLarge: true,),
            Spacer(),
            IconButton(onPressed: (){}, icon: Icon(Icons.share)),


          ],
        ),
        SizedBox(height: SSize.spaceBtwItems/1.5,),

        //product title
        SProductTitle(title:product.title),
        SizedBox(height: SSize.spaceBtwItems/1.5,),

        //status
        Row(
          children: [
            SProductTitle(title: 'Status'),
            SizedBox(width: SSize.spaceBtwItems),
            Text( productController.getProductStockStatus(product.stock),style: Theme.of(context).textTheme.titleMedium,),
          ],
        ),
        SizedBox(height: SSize.spaceBtwItems/1.5,),

        Row(

          children: [
            SCircularImage(image: product.brand !=null ? product.brand!.image : '',
              isNetworkImage: true,
              width: 32,
              height: 32,
              showBorder: false,
            ),
            SizedBox(width: SSize.spaceBtwItems,),
            SBrandTitleWithVerifyIcon(title:product.brand !=null ? product.brand!.name : ''),
          ],
        ),


        //row
      ],
    );

  }
}
