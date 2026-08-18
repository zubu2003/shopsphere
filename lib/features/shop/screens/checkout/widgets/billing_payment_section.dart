import 'package:flutter/material.dart';
import 'package:shopsphere/common/custom_shapes/rounded_container.dart';
import 'package:shopsphere/common/texts/section_heading.dart';
import 'package:shopsphere/utils/constant/colors.dart';
import 'package:shopsphere/utils/constant/image_string.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

class SBillingPaymentSection extends StatelessWidget {
  const SBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        SSectionHeading(
          title: "Payment Method",
          buttonTitle: "Change",
          onPressed: (){},
        ),
        SizedBox(height: SSize.spaceBtwItems/2,),
        
        Row(
          children: [
            SRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark? SColors.light : SColors.white,
              padding: EdgeInsets.all(SSize.sm),
              child: Image(image: AssetImage(SImages.masterCard),fit: BoxFit.contain,),
            ),
            Text("Mastercard",style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ),

      ],
    );
  }
}
