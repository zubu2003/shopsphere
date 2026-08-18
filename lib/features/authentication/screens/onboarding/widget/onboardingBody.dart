import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../utils/helper/device_utility.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({
    super.key, required this.animation, required this.title, required this.subtitle,
  });

  final String animation;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SDeviceUtils.getAppBarHeight(),),
      child: Column(
        children: [
          Lottie.asset(animation),
          Text(title,style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(subtitle,style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}