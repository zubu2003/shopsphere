import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/common/shimmer/shimmer_effect.dart';
import 'package:shopsphere/features/personalization/controllers/user_controller.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../../../../common/appbar/SAppbar.dart';
import '../../../../../common/product/cart/cart_counter_icon.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/text_strings.dart';

class SHomeAppBar extends StatelessWidget {
  const SHomeAppBar({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(UserController());

    return SAppBar(
      showLeading: false,

      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(SHelperFunctions.getGreetingMessage(),
              style: Theme.of(context).textTheme. labelMedium !. apply(color: SColors.grey)),
          /// SubTitle
          Obx(
              (){
                if(controller.profileLoading.value){
                  return SShimmerEffect(width: 80, height: 15);
                }
                return  Text(controller.user.value.fullName,
                    style: Theme.of(context).textTheme.headlineSmall !. apply(color: SColors.white));

              }
          ),
        ],
      ),

      actions: [
        SCartCounterIcon(dark: dark)
      ],
    );
  }
}