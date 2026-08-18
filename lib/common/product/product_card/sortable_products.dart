import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/product/product_card/product_card_vertical.dart';
import 'package:shopsphere/features/shop/models/product_model.dart';

import '../../../utils/constant/size.dart';
import '../../layout/grid_layout.dart';

class SSortableProducts extends StatelessWidget {
  const SSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //filter
        DropdownButtonFormField(
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value){},
          items: ["Name" , "Lower Price", "Higher Price", "Top Sale","Latest"].map((filter){
            return DropdownMenuItem(value: filter,child: Text(filter));
          }).toList(),
        ),
        SizedBox(height: SSize.spaceBtwSections,),

        //grid view product
        SGridLayout(
          itemCount: 10,
          itemBuilder: (context,index)=>SProductCardVertical(product: ProductModel.empty(),),
        )
      ],
    );
  }
}
