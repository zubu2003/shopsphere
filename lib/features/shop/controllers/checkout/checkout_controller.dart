import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/texts/section_heading.dart';
import 'package:shopsphere/utils/constant/size.dart';

import '../../../../common/custom_shapes/rounded_container.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/image_string.dart';
import '../../../../utils/helper/helper_functions.dart';
import '../../models/payment_method_model.dart';
import '../../screens/checkout/widgets/payment_tile.dart';

class CheckoutController extends GetxController{

  static CheckoutController get instance => Get.find();

  ///Variables
  Rx<PaymentMethodModel> selectedPaymentMethod=PaymentMethodModel.empty().obs;


  @override
  void onInit() {
    selectedPaymentMethod.value=PaymentMethodModel(name: "Cash on Delivery", image: SImages.codIcon);
  }

  ///Fucntion to select payment method
  Future<void> selectPaymentMethod(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (context)=> SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(SSize.lg),
            child: Column(
              children: [
                SSectionHeading(title: "Select Payment Method",actionButton: false,),
                SizedBox(height: SSize.spaceBtwItems,),

                SPaymentTile(
                  paymentMethod: PaymentMethodModel(
                    name: 'Cash on delivery',
                    image: SImages.codIcon,
                  ),
                ),

                SizedBox(height: SSize.spaceBtwItems / 2),

                SPaymentTile(
                  paymentMethod: PaymentMethodModel(
                    name: 'Paypal',
                    image: SImages.paypal,
                  ),
                ),

                SizedBox(height: SSize.spaceBtwItems / 2),

                SPaymentTile(
                  paymentMethod: PaymentMethodModel(
                    name: 'Credit Card',
                    image: SImages.creditCard,
                  ),
                ),

                SizedBox(height: SSize.spaceBtwItems / 2),

                SPaymentTile(
                  paymentMethod: PaymentMethodModel(
                    name: 'Master Card',
                    image: SImages.masterCard,
                  ),
                ),

                SizedBox(height: SSize.spaceBtwItems / 2),




              ],
            ),
          ),
        )
    );
  }

}










