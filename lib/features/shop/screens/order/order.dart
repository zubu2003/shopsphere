import 'package:flutter/material.dart';
import 'package:shopsphere/common/appbar/SAppbar.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/features/shop/screens/order/widgets/SOrderListItem.dart';


class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        title: Text("My order",style: Theme.of(context).textTheme.headlineMedium,),
        showLeading: true,
      ),
      body: Padding(
          padding: SPadding.screenPadding,
        child: SOrderlistitem(),
      ),
    );
  }
}
