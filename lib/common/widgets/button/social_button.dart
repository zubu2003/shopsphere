import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/features/authentication/controllers/login/login_controller.dart';

import '../../../utils/constant/colors.dart';
import '../../../utils/constant/image_string.dart';
import '../../../utils/constant/size.dart';
class SScoialButton extends StatelessWidget {
  const SScoialButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(LoginController());

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(SImages.googleIcon,controller.googleSignIn,),

        SizedBox(width: SSize.spaceBtwItems),
        buildButton(SImages.fbIcon,(){

        }),

      ],);
  }

  Container buildButton(String image, VoidCallback onPressed) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: SColors.grey),
            borderRadius: BorderRadius.all(Radius.circular(100))
        ),
        child: IconButton(
            onPressed: onPressed,
            icon: Image.asset(image,width:SSize.iconMd,height: SSize.iconMd,)
        ),
      );
  }
}