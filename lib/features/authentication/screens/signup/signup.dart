import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/common/widgets/login_signup/form_divider.dart';
import 'package:shopsphere/features/authentication/screens/signup/widget/signup%20form.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/constant/text_strings.dart';

import '../../../../common/widgets/button/social_button.dart';
import '../../controllers/signup/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller=Get.put(SignupController());


    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
            padding: SPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //header text
              Text(STexts.signupTitle,style: Theme.of(context).textTheme.headlineMedium,),
              SizedBox(height: SSize.spaceBtwSections,),

              //signup form---------
              SSignUpForm(),
              SizedBox(height: SSize.spaceBtwSections,),

              //divider
              SFormDivider(title: STexts.orSignupWith),
              SizedBox(height: SSize.spaceBtwItems,),
              //social button
              SScoialButton(),

            ],
          ),
        ),
      ),
    );
  }
}




