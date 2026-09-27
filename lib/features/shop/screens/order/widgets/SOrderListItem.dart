import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/custom_shapes/rounded_container.dart';
import 'package:shopsphere/common/loaders/animation_loader.dart';
import 'package:shopsphere/features/shop/models/order_model.dart';
import 'package:shopsphere/utils/constant/colors.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/helper/cloud_helper_functions.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../../../../utils/constant/enums.dart';
import '../../../controllers/order/order_controller.dart';

class SOrderlistitem extends StatelessWidget {
  const SOrderlistitem({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    final controller = Get.put(OrderController());

    return FutureBuilder<List<OrderModel>>(
      future: controller.fetchUserOrders(),
      builder: (context, snapshot) {
        final nothingFound = SAnimationLoader(
          text: "No order yet",
          showActionButton: true,
        );

        final widget = SCloudHelperFunctions.checkMultiRecordState(
          snapshot: snapshot,
          nothingFound: nothingFound,
        );

        if (widget != null) return widget;

        final List<OrderModel> orders = snapshot.data!;

        return ListView.separated(
          itemCount: orders.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(
            height: SSize.spaceBtwItems,
          ),
          itemBuilder: (context, index) {
            final order = orders[index];

            return SRoundedContainer(
              showBorder: true,
              backgroundColor:
              dark ? SColors.dark : SColors.light,
              child: Padding(
                padding: const EdgeInsets.all(SSize.md),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ------------------------------------------------
                    // 1 - Status & Order Date
                    // ------------------------------------------------
                    Row(
                      children: [
                        const Icon(Iconsax.ship),

                        const SizedBox(
                          width: SSize.spaceBtwItems / 2,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.status.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(
                                color: SColors.primary,
                                fontWeightDelta: 1,
                              ),
                            ),

                            Text(
                              _formatDate(order.orderDate),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall,
                            ),
                          ],
                        ),

                        const Spacer(),

                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Iconsax.arrow_right_3,
                            size: SSize.iconSm,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: SSize.spaceBtwItems,
                    ),

                    // ------------------------------------------------
                    // 2 - Order ID & Delivery Date
                    // ------------------------------------------------
                    Row(
                      children: [
                        // Order ID
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Iconsax.tag),

                              const SizedBox(
                                width: SSize.spaceBtwItems / 2,
                              ),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge,
                                    ),

                                    Text(
                                      order.id,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Delivery Date
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Iconsax.calendar),

                              const SizedBox(
                                width: SSize.spaceBtwItems / 2,
                              ),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Shipping Date",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge,
                                    ),

                                    Text(
                                      order.deliveryDate != null
                                          ? _formatDate(
                                        order.deliveryDate!,
                                      )
                                          : "Not available",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Format Date
  String _formatDate(DateTime date) {
    return "${date.day} ${_monthName(date.month)}, ${date.year}";
  }

  String _monthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];

    return months[month - 1];
  }
}
