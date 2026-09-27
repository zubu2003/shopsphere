import 'package:flutter/material.dart';
import 'package:shopsphere/features/shop/controllers/cart/cart_controller.dart';
import 'package:shopsphere/utils/constant/text_strings.dart';

import '../../../../../utils/constant/size.dart';
import '../../../../../utils/helper/pricing_calculator.dart';
class SBillingAmmountSection extends StatelessWidget {
  const SBillingAmmountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final cartController=CartController.instance;
    final subTotal=cartController.totalCartPrice.value;



    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text("Subtotal",style: Theme.of(context).textTheme.bodyMedium,)),
            Text("${STexts.currency}$subTotal",style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        SizedBox(height: SSize.spaceBtwItems/2,),

        //shipping fee
        Row(
          children: [
            Expanded(child: Text("Shipping fee",style: Theme.of(context).textTheme.bodyMedium,)),
            Text("${STexts.currency}${SPricingCalculator.calculateShippingCost(subTotal, "US")}",style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        SizedBox(height: SSize.spaceBtwItems/2,),
        Row(
          children: [
            Expanded(child: Text("Tax fee",style: Theme.of(context).textTheme.bodyMedium,)),
            Text("${STexts.currency}${SPricingCalculator.calculateTax(subTotal, "US")}",style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        SizedBox(height: SSize.spaceBtwItems/2,),
        Row(
          children: [
            Expanded(child: Text("Order total",style: Theme.of(context).textTheme.bodyMedium,)),
            Text("${STexts.currency}${SPricingCalculator.calculateTotalPrice(subTotal, "US")}",style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        SizedBox(height: SSize.spaceBtwItems/2,),

      ],
    );
  }
}
