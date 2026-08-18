import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shopsphere/features/authentication/controllers/onboarding/onboardingController.dart';

import '../../../../../utils/helper/device_utility.dart';

class onBoardingSkipButton extends StatelessWidget {
  const onBoardingSkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller= onboardingController.instance;
    return Obx(
        ()=> controller.currentIndex==2? SizedBox(): Positioned(
          top: SDeviceUtils.getAppBarHeight(),
          right: 0,
          child: TextButton(onPressed:controller.skipButtonClick, child: Text("Skip"))),
    );
  }
}