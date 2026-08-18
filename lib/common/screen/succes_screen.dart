import 'package:flutter/material.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/common/widgets/button/sElevatedbutton.dart';
import 'package:shopsphere/utils/constant/size.dart';
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.title, required this.subtitle, required this.image, required this.onTap});

  final String title, subtitle,image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: SPadding.screenPadding,
        child: Column(
          children: [
            Image.asset(image),

            Text(title,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
            SizedBox(height: SSize.spaceBtwItems,),

            Text(subtitle,style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.center,),
            SizedBox(height: SSize.spaceBtwSections,),

            SElevatedButton(onPressed: onTap, child: Text('Continue')),

          ],
        ),
      ),
    );
  }
}
