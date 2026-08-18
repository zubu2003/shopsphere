import 'package:flutter/material.dart';
import 'package:shopsphere/utils/helper/device_utility.dart';

class SElevatedButton extends StatelessWidget {
  const SElevatedButton({
    super.key, required this.onPressed, required this.child,
  });
  final VoidCallback onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SDeviceUtils.getScreenWidth(context),
      child: ElevatedButton(onPressed: onPressed, child: child)
    );
  }
}