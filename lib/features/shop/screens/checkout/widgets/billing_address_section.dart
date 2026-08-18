import 'package:flutter/material.dart';
import 'package:shopsphere/common/texts/section_heading.dart';
import 'package:shopsphere/utils/constant/colors.dart';
import 'package:shopsphere/utils/constant/size.dart';

class SBillingAddressSection extends StatelessWidget {
  const SBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SSectionHeading(title: "Billing Address",buttonTitle: "Change",onPressed: (){},),
        Text("Shopsphere",style: Theme.of(context).textTheme.titleLarge,),
        SizedBox(height: SSize.spaceBtwItems/2,),

        Row(
          children: [
            Icon(Icons.phone, size: SSize.iconSm,
                color: SColors.darkGrey),
            SizedBox(width: SSize.spaceBtwItems),
            Expanded(child: Text("+88015932656")),

            // ROw
          ],
        ),

        SizedBox(height: SSize.spaceBtwItems/2,),

        Row(
          children: [
            Icon(Icons.location_history, size: SSize.iconSm,
                color: SColors.darkGrey),
            SizedBox(width: SSize.spaceBtwItems),
            Expanded(child: Text(
                'House No.295, Mirpur, Dhaka, Bangladesh', softWrap: true)),

            // ROw
          ],
        ),
      ]
    );
  }
}
