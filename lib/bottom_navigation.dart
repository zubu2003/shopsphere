import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/features/shop/screens/home/homeScreen.dart';
import 'package:shopsphere/features/shop/screens/store/store.dart';
import 'package:shopsphere/features/shop/screens/wishlist/wishlist.dart';
import 'package:shopsphere/utils/constant/colors.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import 'features/personalization/screens/profile.dart';
class BottomNavigationMenu extends StatelessWidget {
  const BottomNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final dark= SHelperFunctions.isDarkMode(context);
    final controller = Get.put(NavigationController());

    return Scaffold(
      body: Obx( ()=> controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        ()=> NavigationBar(
          backgroundColor:dark? SColors.dark:  SColors.light,
          indicatorColor:dark?SColors.white.withValues(alpha: 0.1): SColors.black.withValues(alpha: 0.1),
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index){
            controller.selectedIndex.value=index;
          },
          destinations:[
            NavigationDestination(icon: Icon(Iconsax.home), label:'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label:'Store'),
            NavigationDestination(icon: Icon(Iconsax.heart), label:'Wishlist'),
            NavigationDestination(icon: Icon(Icons.person), label:'Profile'),
          ] ,
        ),
      )
    );
  }
}

class NavigationController extends GetxController{
  static NavigationController get instance => Get.find();
  RxInt selectedIndex=0.obs;

  List<Widget> screens=[Homescreen(),StoreScreen(),WishlistScreen(),ProfileScreen()];
}


