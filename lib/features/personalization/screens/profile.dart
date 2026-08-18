import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/texts/section_heading.dart';
import 'package:shopsphere/data/repositories/authentication_repository.dart';
import 'package:shopsphere/features/personalization/screens/widget/profile_header.dart';
import 'package:shopsphere/features/personalization/screens/widget/profile_tile.dart';
import 'package:shopsphere/features/personalization/screens/widget/settings_tile.dart';
import 'package:shopsphere/features/shop/screens/cart/cart.dart';
import 'package:shopsphere/features/shop/screens/order/order.dart';
import 'package:shopsphere/utils/constant/size.dart';

import 'address/address.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SProfileHeader(),
          //user profile details
          Padding(
            padding: const EdgeInsets.all(SSize.defaultSpace),
            child: Column(
              children: [
                SProfileTile(),
                //account setting heading
                SSectionHeading(title: "Account Settings",actionButton: false,),
                //account settings menu
                SSettingMenuTile(icon: Iconsax.safe_home,
                  title: 'My Addresses',
                  subTitle: 'Set shopping delivery addresses',
                  onTap:()=>Get.to(()=> AddressScreen()),),
                SSettingMenuTile(icon: Iconsax.shopping_cart,
                  title: 'My Cart',
                  subTitle: 'Add, remove products and move to checkout',
                  onTap:()=>Get.to(()=> CartScreen()),),
                SSettingMenuTile(icon: Iconsax.bag_tick,
                  title: 'My Orders',
                  subTitle: 'In-progress and Completed Orders',
                  onTap: ()=>Get.to(()=>OrderScreen()),),
                SizedBox(height: SSize.spaceBtwSections,),

                SizedBox(width: double.infinity,
                child: OutlinedButton(onPressed: AuthenticationRepository.instance.logout, child: Text("Logout")),
                )
              
              ],
            ),
          ),



        ],
      ),
    );
  }
}










