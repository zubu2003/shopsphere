import 'package:flutter/material.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/common/texts/section_heading.dart';
import 'package:shopsphere/common/product/product_card/horizontal_product_card.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../../../common/appbar/SAppbar.dart';

class SubcategoryScreen extends StatelessWidget {
  const SubcategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: SAppBar(
        title: Text("Sports",style: Theme.of(context).textTheme.headlineSmall,),
        showLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: SPadding.screenPadding,
          child: Column(
            children: [

              //sub category
              SSectionHeading(title: "Sports Shoes",onPressed: (){},),
              SizedBox(height: SSize.spaceBtwItems/2,),
              
              //horizontal product card
              SizedBox(
                height: 120,
                  child:ListView.separated(
                    scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      separatorBuilder: (context,index)=>SizedBox(width: SSize.spaceBtwItems,),
                      itemBuilder: (context,index)=>SProductCardHorizontal(),
                      ),
              ),

              //sub category
              SSectionHeading(title: "Sports Shoes",onPressed: (){},),
              SizedBox(height: SSize.spaceBtwItems/2,),

              //horizontal product card
              SizedBox(
                height: 120,
                child:ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  separatorBuilder: (context,index)=>SizedBox(width: SSize.spaceBtwItems,),
                  itemBuilder: (context,index)=>SProductCardHorizontal(),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}



