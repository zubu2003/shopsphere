import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/common/shimmer/shimmer_effect.dart';

import '../../features/personalization/controllers/user_controller.dart';
import '../../utils/constant/image_string.dart';
import 'circular_image.dart';

class SUserProfileLogo extends StatelessWidget {
  const SUserProfileLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller=UserController.instance;
    return Obx(
        (){
          bool isProfileAvailable=controller.user.value.profilePicture.isNotEmpty;

          if(controller.isProfileUploading.value){
            return SShimmerEffect(width: 120, height: 120);
          }


          return SCircularImage(
            image: isProfileAvailable? controller.user.value.profilePicture : SImages.profileImage,
            height: 120,
            width: 120,
            borderWidth: 5,
            padding: 0,
            isNetworkImage: isProfileAvailable? true : false,
          );
        }
    );
  }
}
