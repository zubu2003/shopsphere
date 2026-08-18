import 'package:flutter/cupertino.dart';
import 'package:shopsphere/features/authentication/controllers/onboarding/onboardingController.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/helper/device_utility.dart';

class onBoardingIndicator extends StatelessWidget {
   const onBoardingIndicator({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
  final controller = onboardingController.instance;
    return Positioned(
        bottom: SDeviceUtils.getBottomNavigationBarHeight()*5,
        left: SDeviceUtils.getScreenWidth(context) /2.5,
        right: SDeviceUtils.getScreenWidth(context)/2.5,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect: ExpandingDotsEffect(dotHeight: 6),
        )
    );
  }
}