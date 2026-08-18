import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/features/authentication/controllers/login/login_controller.dart';
import 'package:shopsphere/features/authentication/screens/login/widget/login_form.dart';
import 'package:shopsphere/features/authentication/screens/login/widget/login_header.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/constant/text_strings.dart';

import '../../../../common/widgets/button/social_button.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(LoginController());


    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              //---header
              SLoginHeader(),
        
              SizedBox(height: SSize.spaceBtwSections),
        
              //---login form
              SLoginForm(),
              SizedBox(height: SSize.spaceBtwSections),
              //---footer part---
              SFormDivider(title: STexts.orSignInWith),
        
              SizedBox(height: SSize.spaceBtwSections),
              //----social buttons---
              SScoialButton()
            ],
          ),
        ),
      ),
    );
  }
}








