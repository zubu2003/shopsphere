import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/features/shop/models/product_model.dart';
import 'package:shopsphere/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:shopsphere/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:shopsphere/features/shop/screens/product_details/widgets/product_thumbnail_and_slider.dart';
import 'package:shopsphere/features/shop/screens/product_details/widgets/products_attributes.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';
import '../../../../common/widgets/button/sElevatedbutton.dart';
import '../../../../utils/constant/size.dart';
class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///-------product image with slider------
            SProductThumbnailAndSlider(),

            Padding(
              padding: SPadding.screenPadding,
              child: Column(
                children: [
                  ///----product details--------
                  //discount tag,price and share icon
                  SProductMetaData(),
                  SizedBox(height: SSize.spaceBtwSections,),
                  //attributes
                  SProductsAttributes(),
                  SizedBox(height: SSize.spaceBtwSections,),

                  //checkout button
                  SElevatedButton(onPressed: (){}, child: Text("Checkout")),
                  SizedBox(height: SSize.spaceBtwSections,),
                  //description
                  ReadMoreText(
                    "Iphone 11 with 128GB.Iphone 11 with 128GB.Iphone "
                        "11 with 128GB.Iphone 11 with 128GB.Iphone 11 with 128GB.Iphone 11 with 128GB.Iphone 11 with 128GB.Iphone 11 with 128GB ",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: "Show more",
                    trimExpandedText: "Less",
                    moreStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w800),
                    lessStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: SSize.spaceBtwSections,),
                ],
              ),
            ),
          ],
        ),
      ),

      //bottom cart button
      bottomNavigationBar: BottomAddToCart(),
    );
  }
}






