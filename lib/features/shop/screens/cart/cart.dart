import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/common/appbar/SAppbar.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/common/widgets/button/sElevatedbutton.dart';
import 'package:shopsphere/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:shopsphere/features/shop/screens/checkout/checkout.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: SAppBar(
        showLeading: true,
        title: Text("Cart",style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: Padding(
          padding: SPadding.screenPadding,
        child: SCartItems(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(SSize.defaultSpace),
        child: SElevatedButton(onPressed: ()=>Get.to(()=>CheckoutScreen()), child: Text("Checkout \$2345"),),
      ),
    );
  }
}





