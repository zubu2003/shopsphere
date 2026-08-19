import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/product/product_card/product_card_vertical.dart';
import 'package:shopsphere/features/shop/controllers/product/all_product_controller.dart';
import 'package:shopsphere/features/shop/controllers/product/product_controller.dart';
import 'package:shopsphere/features/shop/models/product_model.dart';

import '../../../utils/constant/size.dart';
import '../../layout/grid_layout.dart';

class SSortableProducts extends StatelessWidget {
  const SSortableProducts({
    super.key, required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final allproductController=AllProductsController.instance;
    allproductController.assignProducts(products);

    return Column(
      children: [
        //filter
        DropdownButtonFormField(
          value:allproductController.selectedSortOption.value ,
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value)=> allproductController.sortProducts(value!),
          items: ["Name" , "Lower Price", "Higher Price", "Sale","Latest"].map((filter){
            return DropdownMenuItem(value: filter,child: Text(filter));
          }).toList(),
        ),
        SizedBox(height: SSize.spaceBtwSections,),

        //grid view product
        Obx(
        ()=> SGridLayout(
            itemCount: allproductController.products.length,
            itemBuilder: (context,index)=>SProductCardVertical(product:allproductController.products[index],),
          ),
        )
      ],
    );
  }
}
