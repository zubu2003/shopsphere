import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/appbar/SAppbar.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/features/personalization/screens/address/widgets/single_address.dart';
import 'package:shopsphere/utils/constant/colors.dart';
import 'package:shopsphere/utils/constant/size.dart';

import 'add_new_address.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        title: Text("Address",style: Theme.of(context).textTheme.headlineMedium),
        showLeading: true,
      ),
      body: Padding(
          padding: SPadding.screenPadding,
        child: Column(
          children: [
            SSingleAddress(isSelected: true),
            SizedBox(height: SSize.spaceBtwItems,),
            SSingleAddress(isSelected: false),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: ()=> Get.to(()=>AddNewAddressScreen()),
        backgroundColor: SColors.primary,
        child: Icon(Iconsax.add,color: SColors.white,),
      ),
    );
  }
}






