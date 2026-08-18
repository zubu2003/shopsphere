import 'package:flutter/material.dart';
import 'package:shopsphere/common/chip/choice_chip.dart';
import 'package:shopsphere/common/custom_shapes/rounded_container.dart';
import 'package:shopsphere/common/texts/product_price.dart';
import 'package:shopsphere/common/texts/product_title.dart';
import 'package:shopsphere/common/texts/section_heading.dart';
import 'package:shopsphere/utils/constant/colors.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

class SProductsAttributes extends StatelessWidget {
  const SProductsAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Column(
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
                          SProductPrice(
                            price: "250",
                            lineThrough: true,
                            isLarge: false,
                          ),
                          SizedBox(width: SSize.spaceBtwItems / 2),
                          SProductPrice(price: "150"),
                        ],
                      ),
                      //stock
                      Row(
                        children: [
                          SProductTitle(title: "Status ", smallLine: true),
                          Text(
                            "In Stock",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              //attribute description
              SProductTitle(title: "Ipone 11 with 512GB",maxLine: 4,smallLine: true,),
            ],
          ),

          //title price stock
        ),
        SizedBox(height: SSize.spaceBtwItems,),

        //Color attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SSectionHeading(title: "Colors",actionButton: false,),
            SizedBox(height: SSize.spaceBtwItems/2,),
            Wrap(
              spacing: SSize.sm,
              children: [
                SChoiceChip(text: "Red",selected: true,onSelected: (value){} ),
                SChoiceChip(text: "Blue",selected: false,onSelected: (value){} ),
                SChoiceChip(text: "Green",selected: false,onSelected: (value){} ),
              ],
            ),
          ],
        ),

        //size attribute
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SSectionHeading(title: "Size",actionButton: false,),
            SizedBox(height: SSize.spaceBtwItems/2,),
            Wrap(
              spacing: SSize.sm,
              children: [
                SChoiceChip(text: "M",selected: true,onSelected: (value){} ),
                SChoiceChip(text: "L",selected: true,onSelected: (value){} ),
                SChoiceChip(text: "XL",selected: false,onSelected: (value){} ),
              ],
            ),
          ],
        ),






      ],
    );
  }
}
