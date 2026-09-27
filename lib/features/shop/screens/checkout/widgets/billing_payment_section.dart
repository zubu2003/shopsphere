import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shopsphere/common/custom_shapes/rounded_container.dart';
import 'package:shopsphere/common/texts/section_heading.dart';
import 'package:shopsphere/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:shopsphere/utils/constant/colors.dart';
import 'package:shopsphere/utils/constant/image_string.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

class SBillingPaymentSection extends StatelessWidget {
  const SBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    final checkoutController=Get.put(CheckoutController());

    return Column(
      children: [
        SSectionHeading(
          title: "Payment Method",
          buttonTitle: "Change",
          onPressed: ()=> checkoutController.selectPaymentMethod(context),
        ),
        SizedBox(height: SSize.spaceBtwItems/2,),
        
        Obx(
          ()=> Row(
            children: [
              SRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark? SColors.light : SColors.white,
                padding: EdgeInsets.all(SSize.sm),
                child: Image(image: AssetImage(checkoutController.selectedPaymentMethod.value.image),fit: BoxFit.contain,),
              ),
              Text(checkoutController.selectedPaymentMethod.value.name,style: Theme.of(context).textTheme.bodyLarge,),
            ],
          ),
        ),

      ],
    );
  }
}
