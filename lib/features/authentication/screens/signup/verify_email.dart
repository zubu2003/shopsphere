import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/common/widgets/button/sElevatedbutton.dart';
import 'package:shopsphere/data/repositories/authentication_repository.dart';
import 'package:shopsphere/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/constant/text_strings.dart';
class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(VerifyEmailController());


    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: AuthenticationRepository.instance.logout , icon: Icon(Icons.close)),
        ],
      ),
      body: Padding(
        padding: SPadding.screenPadding,
        child: Column(
          children: [
            //image
            Image.asset('assets/images/mail_illustration.png'),

            //title
            Text(STexts.verifyEmailTitle,style: Theme.of(context).textTheme.headlineMedium,),
            SizedBox(height: SSize.spaceBtwItems,),

            //subtitile
            Text(email?? '',style: Theme.of(context).textTheme.labelMedium,),
            SizedBox(height: SSize.spaceBtwItems,),

            Text(STexts.verifyEmailSubTitle,style: Theme.of(context).textTheme.bodySmall,textAlign: TextAlign.center,),
            SizedBox(height: SSize.spaceBtwSections,),

            SElevatedButton(
              onPressed: controller.checkEmailVerifyStatus,
               child: Text('Continue')
            ),
            SizedBox(height: SSize.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              child: TextButton(onPressed: controller.sendEmailVerification, child: Text(STexts.resendEmail)),
            ),
          ],
        ),
      ),
    );
  }
}
