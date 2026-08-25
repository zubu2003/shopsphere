import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/features/personalization/controllers/address_controller.dart';
import 'package:shopsphere/features/personalization/models/address_model.dart';
import 'package:shopsphere/utils/constant/colors.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../../../../common/custom_shapes/rounded_container.dart';
import '../../../../../utils/constant/size.dart';
class SSingleAddress extends StatelessWidget {
  const SSingleAddress({
    super.key,required this.address, required this.onTap,
  });

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller= AddressController.instance;
    final dark=SHelperFunctions.isDarkMode(context);
    return Obx(
        (){

          final selectedAddressId=controller.selectedAddress.value.id;
          bool isSelected= selectedAddressId == address.id;

          return InkWell(
            onTap: onTap,
            child: SRoundedContainer(
              width: double.infinity,
              showBorder: true,
              backgroundColor: isSelected? SColors.primary.withValues(alpha: 0.5): Colors.transparent,
              borderColor: isSelected? Colors.transparent : dark? SColors.darkGrey:SColors.grey,
              padding: EdgeInsets.all(SSize.md),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(address.name,style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: SSize.spaceBtwItems,),
                      Text(address.phoneNumber,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: SSize.spaceBtwItems,),
                      Text(address.toString()),

                    ],
                  ),

                  //selected button
                  if(isSelected)Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      child: Icon(Iconsax.tick_circle5)
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
