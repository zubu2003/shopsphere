import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/common/chip/choice_chip.dart';
import 'package:shopsphere/common/custom_shapes/rounded_container.dart';
import 'package:shopsphere/common/texts/product_price.dart';
import 'package:shopsphere/common/texts/product_title.dart';
import 'package:shopsphere/common/texts/section_heading.dart';
import 'package:shopsphere/features/shop/controllers/product/variation_controller.dart';
import 'package:shopsphere/utils/constant/colors.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../../models/product_model.dart';

class SProductsAttributes extends StatelessWidget {
  const SProductsAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {

    final variationController=Get.put(VariationController());

    final dark = SHelperFunctions.isDarkMode(context);
    return Obx(
        ()=> Column(
        children: [
          //container
          SRoundedContainer(
            padding: EdgeInsets.all(SSize.sm),
            backgroundColor: dark ? SColors.darkGrey : SColors.grey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //price
                Row(
                  children: [
                    SSectionHeading(title: "Variation", actionButton: false),
                    SizedBox(width: SSize.spaceBtwItems),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //price
                        Row(
                          children: [
                            SProductTitle(title: "Price:"),
                            SizedBox(width: SSize.spaceBtwItems / 2),
                            if(variationController.selectedVariation.value.salePrice > 0)
                            SProductPrice(
                              price: variationController.selectedVariation.value.price.toStringAsFixed(0),
                              lineThrough: true,
                              isLarge: false,
                            ),
                            SizedBox(width: SSize.spaceBtwItems / 2),
                            SProductPrice(price: variationController.getVariationPrice()),
                          ],
                        ),
                        //stock
                        Row(
                          children: [
                            SProductTitle(title: "Status ", smallLine: true),
                            Text(variationController.variationStockStatus.value,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                //attribute description
                SProductTitle(title: variationController.selectedVariation.value.description?? '',maxLine: 4,smallLine: true,),
              ],
            ),

            //title price stock
          ),
          SizedBox(height: SSize.spaceBtwItems,),

          //Color attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!.map((attribute){
              return Obx(
                ()=> Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SSectionHeading(title: attribute.name ?? '',actionButton: false,),
                    SizedBox(height: SSize.spaceBtwItems/2,),
                    Wrap(
                      spacing: SSize.sm,
                      children: attribute.values!.map((attributeValue) {

                        bool isSelected = variationController.selectedAttributes[attribute.name] == attributeValue;

                        final available=variationController.getAttributesAvailabilityInVariation(
                            product.productVariations!, attribute.name!).contains(attributeValue);

                        return SChoiceChip(
                          text: attributeValue,
                          selected: isSelected,
                          onSelected: available? (selected){
                              if(available && selected){
                                variationController.onAttributeSelected(product, attribute.name!, attributeValue);
                              }
                          } :null
                        );
                      }).toList(),
                    )
                  ],
                ),
              );
            }).toList()
          ),








        ],
      ),
    );
  }
}
