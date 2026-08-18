import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/features/authentication/controllers/signup/signup_controller.dart';
import 'package:shopsphere/features/authentication/screens/signup/widget/privacy_policy.dart';
import 'package:shopsphere/utils/validators/validation.dart';

import '../../../../../common/widgets/button/sElevatedbutton.dart';
import '../../../../../utils/constant/size.dart';

class SSignUpForm extends StatelessWidget {
  const SSignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final controller=SignupController.instance;

    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          //first last name
          Row(children: [
            Expanded(
              child: TextFormField(
                controller: controller.firstName,
                validator: (value)=> SValidator.validateEmptyText("First Name", value),
                decoration: InputDecoration(
                  labelText: "First Name",
                  prefixIcon: Icon(Icons.person_2),
                ),
              ),
            ),
            SizedBox(width: SSize.spaceBtwItems,),
            Expanded(
              child: TextFormField(
                controller: controller.lastName,
                validator: (value)=> SValidator.validateEmptyText("Last Name", value),
                decoration: InputDecoration(
                  labelText: "Last Name",
                  prefixIcon: Icon(Icons.person_2),
                ),
              ),
            ),
          ],),
          SizedBox(height: SSize.spaceBtwItems,),
          TextFormField(
            controller: controller.email,
            validator: (value)=> SValidator.validateEmail(value),
            decoration: InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
          SizedBox(height: SSize.spaceBtwItems,),
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value)=> SValidator.validatePhoneNumber(value),
            decoration: InputDecoration(
              labelText: "Phone Number",
              prefixIcon: Icon(Icons.phone),
            ),
          ),
          SizedBox(height: SSize.spaceBtwItems,),
          Obx(
          ()=> TextFormField(
              obscureText: !controller.isPasswordVisible.value,
              controller: controller.password,
              validator: (value)=> SValidator.validatePassword(value),
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Iconsax.lock),
                suffixIcon: IconButton(onPressed:()=> controller.isPasswordVisible.value= !controller.isPasswordVisible.value, icon:Icon(controller.isPasswordVisible.value ? Iconsax.eye : Iconsax.eye_slash),)
              ),
            ),
          ),

          SizedBox(height: SSize.spaceBtwItems,),

          // checkbox and text
          SPrivacyPolicey(),
          SizedBox(height: SSize.spaceBtwSections,),

          //button
          SElevatedButton(onPressed:  controller.registerUser, child: Text("Create Account")),

        ],
      ),
    );
  }
}
