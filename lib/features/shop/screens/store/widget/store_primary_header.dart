import 'package:flutter/material.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../../../../common/appbar/SAppbar.dart';
import '../../../../../common/product/cart/cart_counter_icon.dart';
import '../../../../../common/textfield/search_bar.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/size.dart';
import '../../../../../common/custom_shapes/primary_header.dart';

class SStorePrimaryHeader extends StatelessWidget {
  const SStorePrimaryHeader({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        SizedBox(height: SSize.storePrimaryHeaderHeight + 10),

        //primary header container
        SHomePrimaryHeader(
          height: SSize.storePrimaryHeaderHeight,
          child: SAppBar(
            title: Text("Store",style: Theme.of(context).textTheme.headlineMedium!.apply(color: SColors.white),),
            actions: [
              SCartCounterIcon()
            ],
          ),
        ),
        //search box container
        SSearchBar(),
      ],
    );
  }
}
