import 'package:flutter/material.dart';

import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';

class SCircularLoader extends StatelessWidget {
  const SCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SSize.lg),
      decoration: const BoxDecoration(
        color: SColors.primary,
        shape: BoxShape.circle
      ),
      child: const CircularProgressIndicator(color: SColors.white,)
    );
  }
}
