import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/appbar/SAppbar.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/features/personalization/controllers/address_controller.dart';
import 'package:shopsphere/features/personalization/models/address_model.dart';
import 'package:shopsphere/features/personalization/screens/address/widgets/single_address.dart';
import 'package:shopsphere/utils/constant/colors.dart';
import 'package:shopsphere/utils/constant/size.dart';

import '../../../../utils/helper/cloud_helper_functions.dart';
import 'add_new_address.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Scaffold(
      appBar: SAppBar(
        title: Text("Address", style: Theme.of(context).textTheme.headlineMedium),
        showLeading: true,
      ),
      body: Padding(
        padding: SPadding.screenPadding,
        child: Obx(
          () => FutureBuilder(
            /// Use the refreshData value as a key to force rebuild when it changes
            key: Key(controller.refreshData.value.toString()),
            future: controller.getAllAdresses(),
            builder: (context, snapshot) {
              /// Handle Error, Loading, Empty
              final widget = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
              if (widget != null) return widget;

              /// data found
              List<AddressModel> adresses = snapshot.data!;

              return ListView.separated(
                itemCount: adresses.length,
                separatorBuilder: (contex, snapshot) => SizedBox(height: SSize.spaceBtwItems),
                itemBuilder: (contex, index) {
                  return SSingleAddress(
                    address: adresses[index],
                    onTap: () => controller.selectAddress(adresses[index]),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddNewAddressScreen()),
        backgroundColor: SColors.primary,
        child: Icon(Iconsax.add, color: SColors.white),
      ),
    );
  }
}
