import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/appbar/SAppbar.dart';
import 'package:shopsphere/common/icon/circular_icon.dart';
import 'package:shopsphere/common/loaders/animation_loader.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/common/widgets/button/sElevatedbutton.dart';
import 'package:shopsphere/features/shop/controllers/cart/cart_controller.dart';
import 'package:shopsphere/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:shopsphere/features/shop/screens/checkout/checkout.dart';
import 'package:shopsphere/utils/constant/image_string.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    final cartController=CartController.instance;
    return Scaffold(
      appBar: SAppBar(
        showLeading: true,
        title: Text("Cart",style: Theme.of(context).textTheme.headlineMedium,),
        actions: [SCircularIcon(icon: Iconsax.box_remove,onPressed: cartController.clearCart,)],
      ),
      body: Obx(
          (){
            
            final emptyWidget=SAnimationLoader(
              text: "cart is empty",
              animation: SImages.cartEmptyAnimation,
              showActionButton: true,
              actionText: "Let's add item",
              onActionPressed: Get.back,
            );

            
            if(cartController.cartItems.isEmpty){
              return emptyWidget;
            }

            return SingleChildScrollView(
              child: Padding(
                padding: SPadding.screenPadding,
                child: SCartItems(),
              ),
            );
          }
      ),
      bottomNavigationBar: Obx(
          (){
            if(cartController.cartItems.isEmpty)return SizedBox();
            return Padding(
              padding: const EdgeInsets.all(SSize.defaultSpace),
              child: SElevatedButton(onPressed: ()=>Get.to(()=>CheckoutScreen()), child: Text("Checkout \$${cartController.totalCartPrice.value.toStringAsFixed(2)}"),),
            );
          }
      ),
    );
  }
}





