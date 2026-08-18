import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shopsphere/features/authentication/controllers/signup/signup_controller.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/text_strings.dart';
class SPrivacyPolicey extends StatelessWidget {
  const SPrivacyPolicey({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    final controller=SignupController.instance;

    return Row(
      children: [
        Obx(()=> Checkbox(value: controller.privacyPolicy.value, onChanged: (value)=> controller.privacyPolicy.value=!controller.privacyPolicy.value)),
        RichText(text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(text:"${STexts.iAgreeTo} " ),
            TextSpan(text: STexts.privacyPolicy,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: dark? SColors.white: SColors.primary,
                decoration: TextDecoration.underline,
              ),
            ),
            TextSpan(text:" ${STexts.and} " ),
            TextSpan(text: STexts.termsOfUse,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color:  dark? SColors.white: SColors.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ))
      ],
    );
  }
}

