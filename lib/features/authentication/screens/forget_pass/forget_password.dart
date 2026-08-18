import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/common/widgets/button/sElevatedbutton.dart';
import 'package:shopsphere/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:shopsphere/features/authentication/screens/forget_pass/reset_pass_screen.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/constant/text_strings.dart';
import 'package:shopsphere/utils/validators/validation.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(ForgetPasswordController());

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: SPadding.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(STexts.forgetPasswordTitle,style: Theme.of(context).textTheme.headlineMedium,),
            Text(STexts.forgetPasswordSubTitle,style: Theme.of(context).textTheme.labelMedium,),

            SizedBox(height: SSize.spaceBtwSections*2,),
            //email field-----
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: (value)=> SValidator.validateEmail(value),
                decoration: InputDecoration(
                  labelText: STexts.email,
                  prefixIcon: Icon(Iconsax.direct_right)
                ),
              ),
            ),
            SizedBox(height: SSize.spaceBtwSections,),
            //button
            SElevatedButton(onPressed: controller.sendPasswordResetEmail  ,child: Text("Submit"))
          ],
        ),
      ),
    );

  }
}
