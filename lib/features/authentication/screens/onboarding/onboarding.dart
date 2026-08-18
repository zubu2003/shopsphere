import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/features/authentication/controllers/onboarding/onboardingController.dart';
import 'package:shopsphere/features/authentication/screens/onboarding/widget/onBoardingNextButton.dart';
import 'package:shopsphere/features/authentication/screens/onboarding/widget/onBoardingSkipButton.dart';
import 'package:shopsphere/features/authentication/screens/onboarding/widget/onboardingIndicator.dart';

import 'package:shopsphere/features/authentication/screens/onboarding/widget/onboardingBody.dart';
import 'package:shopsphere/utils/constant/image_string.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/constant/text_strings.dart';

class OnboardingScreen extends StatelessWidget {
   const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
  final controller= Get.put(onboardingController());
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: SSize.defaultSpace),
        child: Stack(
          children: [
            //main body
            PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: [
                OnBoardingBody(animation:SImages.onboardingAnimation1, title: STexts.onBoardingTitle1, subtitle:STexts.onBoardingSubTitle1,),
                OnBoardingBody(animation:SImages.onboardingAnimation2, title: STexts.onBoardingTitle1, subtitle:STexts.onBoardingSubTitle2,),
                OnBoardingBody(animation:SImages.onboardingAnimation3, title: STexts.onBoardingTitle1, subtitle:STexts.onBoardingSubTitle3,),

              ],
            ),

            //indiacator
            onBoardingIndicator(),

            //next button
            onBoardingNextButton(),

            //skip button
            onBoardingSkipButton()
          ],
        ),
      ),
    );
  }
}










