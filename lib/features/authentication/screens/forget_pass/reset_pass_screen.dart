import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/common/widgets/button/sElevatedbutton.dart';
import 'package:shopsphere/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:shopsphere/features/authentication/screens/login/login.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/constant/text_strings.dart';
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=ForgetPasswordController.instance;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()=> Get.offAll(LoginScreen()) , icon: Icon(Icons.close)),
        ],
      ),
      body: Padding(
        padding: SPadding.screenPadding,
        child: Column(
          children: [
            Image.asset('assets/images/mail_illustration.png'),

            Text(STexts.resetPasswordTitle,style: Theme.of(context).textTheme.headlineMedium,),
            SizedBox(height: SSize.spaceBtwItems,),

            Text(controller.email.text,style: Theme.of(context).textTheme.labelMedium,),
            SizedBox(height: SSize.spaceBtwItems,),

            Text(STexts.resetPasswordSubTitle,style: Theme.of(context).textTheme.labelMedium,),
            SizedBox(height: SSize.spaceBtwSections,),

            SElevatedButton(onPressed: ()=> Get.offAll(()=> LoginScreen()), child: Text('Done')),
            SizedBox(height: SSize.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              child: TextButton(onPressed:controller.resendPasswordResetEmail, child: Text(STexts.resendEmail)),
            ),
          ],
        ),
      ),
    );
  }
}
