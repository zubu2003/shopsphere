import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shopsphere/common/appbar/SAppbar.dart';
import 'package:shopsphere/common/custom_shapes/rounded_container.dart';
import 'package:shopsphere/common/screen/succes_screen.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/features/shop/controllers/cart/cart_controller.dart';
import 'package:shopsphere/features/shop/controllers/order/order_controller.dart';
import 'package:shopsphere/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:shopsphere/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:shopsphere/features/shop/screens/checkout/widgets/billing_ammount_section.dart';
import 'package:shopsphere/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:shopsphere/features/shop/screens/checkout/widgets/promo_code.dart';
import 'package:shopsphere/utils/constant/image_string.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';
import 'package:shopsphere/utils/popups/snackbar_helpers.dart';

import '../../../../bottom_navigation.dart';
import '../../../../common/widgets/button/sElevatedbutton.dart';
import '../../../../utils/constant/text_strings.dart';
import '../../../../utils/helper/pricing_calculator.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    final orderController=Get.put(OrderController());
    final cartController=CartController.instance;

    double subTotal=cartController.totalCartPrice.value;
    double totalPrice=SPricingCalculator.calculateTotalPrice(subTotal, "US");

    return Scaffold(
      //---appbar----
      appBar: SAppBar(
        showLeading: true,
        title: Text("Order Review",style: Theme.of(context).textTheme.headlineSmall,),
      ),
      //---body-----
      body: SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: Column(
            children: [
              SCartItems(showAddRemoveButton: false,),

              //prome code
              SPromoCodeField(),
              SizedBox(height: SSize.spaceBtwItems,),

              //
              SRoundedContainer(
                showBorder: true,
                padding: EdgeInsets.all(SSize.md),
                backgroundColor: Colors.transparent,
                child: Column(
                  children: [
                    //ammount
                    SBillingAmmountSection(),
                    SizedBox(height: SSize.spaceBtwItems,),
                    //payment section
                    SBillingPaymentSection(),
                    SizedBox(height: SSize.spaceBtwItems,),
                    //address section
                    SBillingAddressSection(),
                  ],
                ),
              ),



            ],
          ),
        ),
      ),

      ///---checkout button----

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(SSize.defaultSpace),
        child: SElevatedButton(
          onPressed: () {
            // Check cart
            if (orderController.cartController.cartItems.isEmpty) {
              SSnackBarHelpers.errorSnackBar(
                title: 'Empty Cart',
                message: 'You have no items in cart',
              );
              return;
            }

            // Check address
            if (orderController
                .addressController.selectedAddress.value.id.isEmpty) {
              SSnackBarHelpers.errorSnackBar(
                title: 'No Address',
                message: 'Please select a delivery address',
              );
              return;
            }

            // Everything is valid
            orderController.processOrder(totalPrice);
          },
          child: Text(
            "Checkout ${STexts.currency}$totalPrice",
          ),
        ),
      ),



    );
  }
}


