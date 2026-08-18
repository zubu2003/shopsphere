import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/features/authentication/controllers/login/login_controller.dart';
import 'package:shopsphere/features/authentication/screens/forget_pass/forget_password.dart';
import 'package:shopsphere/features/authentication/screens/signup/signup.dart';
import 'package:shopsphere/utils/validators/validation.dart';

import '../../../../../bottom_navigation.dart';
import '../../../../../common/widgets/button/sElevatedbutton.dart';
import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/text_strings.dart';
class SLoginForm extends StatelessWidget {
  const SLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller=LoginController.instance;
    return Form(
      key:controller.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ///email field
          TextFormField(
            validator: (value)=> SValidator.validateEmail(value),
            controller: controller.email,
            decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Iconsax.arrow_right)

            ),
          ),
          SizedBox(height: SSize.spaceBtwInputFields),

          ///password field
          Obx(
              ()=> TextFormField(
              obscureText: !controller.isPasswordVisible.value,
              validator: (value)=> SValidator.validateEmptyText('Password',value),
              controller: controller.password,
              decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Iconsax.lock),
                  suffixIcon: Obx( ()=> IconButton(
                      onPressed: controller.isPasswordVisible.toggle,
                      icon: Icon( controller.isPasswordVisible.value? Iconsax.eye : Iconsax.eye_slash)
                  )
                  )
              ),

            ),
          ),

          //---remeber and forget
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx( ()=> Checkbox(value: controller.rememberMe.value, onChanged: (value)=> controller.rememberMe.toggle())),
                  Text(STexts.rememberMe),
                ],
              ),
              TextButton(onPressed: ()=> Get.to(ForgetPassword()), child: Text(STexts.forgetPassword))
            ],
          ),
          SizedBox(height: SSize.spaceBtwSections),

          //---button
          SElevatedButton(
              onPressed: controller.loginWithEmailAndPassword,
              child: Text(STexts.signIn)
          ),
          SizedBox(height: SSize.spaceBtwItems),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
                onPressed: ()=> Get.to(()=> SignupScreen()),
                child: Text(STexts.createAccount)
            ),
          ),

        ],
      ),
    );
  }
}