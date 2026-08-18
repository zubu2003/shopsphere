import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/appbar/SAppbar.dart';
import 'package:shopsphere/features/personalization/controllers/user_controller.dart';

import '../../../../../common/styles/padding.dart';
import '../../../../../common/widgets/button/sElevatedbutton.dart';
import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/text_strings.dart';
import '../../../../../utils/validators/validation.dart';

class ReAuthenticateUserFormScreen extends StatelessWidget {
  const ReAuthenticateUserFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=UserController.instance;
    return Scaffold(
      appBar: SAppBar(
        title: Text("Re-Authenticate User"),
        showLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              children: [
                /// Email
                TextFormField(
                  controller: controller.email,
                  validator: SValidator.validateEmail,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: STexts.email,
                  ),
                ),

                const SizedBox(height: SSize.spaceBtwInputFields),

                /// Password
                Obx(
                  ()=> TextFormField(
                    controller: controller.password,
                    obscureText: !controller.isPasswordVisible.value,
                    validator: (value) =>
                        SValidator.validateEmptyText('Password', value),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.password_check),
                      labelText: STexts.password,
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Obx(()=> IconButton(onPressed: ()=> controller.isPasswordVisible.toggle(), icon: Icon(controller.isPasswordVisible.value? Iconsax.eye: Iconsax.eye_slash),))
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: SSize.spaceBtwSections),

                /// Verify Button
                SizedBox(
                  width: double.infinity,
                  child: SElevatedButton(
                    onPressed:controller.reAuthenticateUser,
                    child: const Text('Verify'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
