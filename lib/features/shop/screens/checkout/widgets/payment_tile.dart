
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/features/shop/controllers/checkout/checkout_controller.dart';

import '../../../../../common/custom_shapes/rounded_container.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/size.dart';
import '../../../../../utils/helper/helper_functions.dart';
import '../../../models/payment_method_model.dart';

class SPaymentTile extends StatelessWidget {
  const SPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller=CheckoutController.instance;


    return ListTile(
      onTap: () {
        controller.selectedPaymentMethod.value=paymentMethod;
        Get.back();
      },
      contentPadding: EdgeInsets.zero,
      leading: SRoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: SHelperFunctions.isDarkMode(context)
            ? SColors.light
            : SColors.white,
        padding: EdgeInsets.all(SSize.sm),
        child: Image(
          image: AssetImage(paymentMethod.image),
          fit: BoxFit.contain,
        ),
      ),
      title:  Text(paymentMethod.name),
      trailing: Icon(Iconsax.arrow_right_3),
    );
  }
}
