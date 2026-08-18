import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/features/personalization/controllers/user_controller.dart';

import '../../../../../common/icon/circular_icon.dart';
import '../../../../../common/images/user_logo.dart';

class SUserProfileWithEditIcon extends StatelessWidget {
  const SUserProfileWithEditIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller=UserController.instance;
    return Stack(
      children: [
        //profile logo
        Center(child: SUserProfileLogo()),

        //edit icon
       Obx(
           (){
             if(controller.isProfileUploading.value){
               return SizedBox();
             }else{
              return  Positioned(
                   top: 0,
                   bottom: 0,
                   right: 0,
                   left: 0,
                   child: Center(child: SCircularIcon(icon: Iconsax.edit,onPressed: controller.updateUserProfilePicture,)));
             }
           }
       ),
      ],
    );
  }
}
