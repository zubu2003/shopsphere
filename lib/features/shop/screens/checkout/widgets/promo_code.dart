import 'package:flutter/material.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../../../../common/custom_shapes/rounded_container.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/size.dart';

class SPromoCodeField extends StatelessWidget {
  const SPromoCodeField({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    return SRoundedContainer(
      showBorder: true,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.only(left: SSize.md,top: SSize.sm,right: SSize.sm,bottom:SSize.sm ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Have a promo code?Apply here",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

              ),
            ),
          ),

          //apply button
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.withValues(alpha: 0.2),
                foregroundColor: dark? Colors.white.withValues(alpha: 0.5): SColors.dark.withValues(alpha: 0.5),
                side: BorderSide(color: SColors.grey.withValues(alpha: 0.1)),
              ),
              child: Text("Apply"),
            ),
          ),
        ],
      ),
    );
  }
}
