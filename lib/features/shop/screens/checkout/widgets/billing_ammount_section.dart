import 'package:flutter/material.dart';

import '../../../../../utils/constant/size.dart';
class SBillingAmmountSection extends StatelessWidget {
  const SBillingAmmountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text("Subtotal",style: Theme.of(context).textTheme.bodyMedium,)),
            Text("\$343",style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        SizedBox(height: SSize.spaceBtwItems/2,),
        Row(
          children: [
            Expanded(child: Text("Shipping fee",style: Theme.of(context).textTheme.bodyMedium,)),
            Text("\$13",style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        SizedBox(height: SSize.spaceBtwItems/2,),
        Row(
          children: [
            Expanded(child: Text("Tax fee",style: Theme.of(context).textTheme.bodyMedium,)),
            Text("\$4",style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        SizedBox(height: SSize.spaceBtwItems/2,),
        Row(
          children: [
            Expanded(child: Text("Order total",style: Theme.of(context).textTheme.bodyMedium,)),
            Text("\$360",style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        SizedBox(height: SSize.spaceBtwItems/2,),

      ],
    );
  }
}
