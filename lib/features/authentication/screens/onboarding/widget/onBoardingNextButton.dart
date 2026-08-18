import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/features/authentication/controllers/onboarding/onboardingController.dart';

import '../../../../../common/widgets/button/sElevatedbutton.dart';
import '../../../../../utils/helper/device_utility.dart';
class onBoardingNextButton extends StatelessWidget {
   const onBoardingNextButton({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
  final controller = onboardingController.instance;
    return Positioned(
      bottom: SDeviceUtils.getBottomNavigationBarHeight(),
      left: 0,
      right: 0,
      child: SElevatedButton(
        onPressed:controller.nextButtonClick,
        child:Obx(()=> controller.currentIndex.value==2? Text("Get Started") : Text("Next")),
      ),
    );
  }
}