import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/common/texts/section_heading.dart';
import 'package:shopsphere/features/personalization/controllers/address_controller.dart';
import 'package:shopsphere/utils/constant/colors.dart';
import 'package:shopsphere/utils/constant/size.dart';

class SBillingAddressSection extends StatelessWidget {
  const SBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SSectionHeading(
          title: "Billing Address",
          buttonTitle: "Change",
          onPressed: () =>
              controller.selectNewAddressBottomSheet(context),
        ),

        Obx(() {
          // No address selected
          if (controller.selectedAddress.value.id.isEmpty) {
            return const Text("No address found");
          }

          final address = controller.selectedAddress.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),

              SizedBox(
                height: SSize.spaceBtwItems / 2,
              ),

              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: SSize.iconSm,
                    color: SColors.darkGrey,
                  ),

                  SizedBox(
                    width: SSize.spaceBtwItems,
                  ),

                  Expanded(
                    child: Text(address.phoneNumber),
                  ),
                ],
              ),

              SizedBox(
                height: SSize.spaceBtwItems / 2,
              ),

              Row(
                children: [
                  Icon(
                    Icons.location_history,
                    size: SSize.iconSm,
                    color: SColors.darkGrey,
                  ),

                  SizedBox(
                    width: SSize.spaceBtwItems,
                  ),

                  Expanded(
                    child: Text(
                      '${address.street}, '
                          '${address.city}, '
                          '${address.state}, '
                          '${address.country}',
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ],
    );
  }
}
