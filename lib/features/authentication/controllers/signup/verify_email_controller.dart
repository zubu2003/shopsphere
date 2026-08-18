import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopsphere/common/screen/succes_screen.dart';
import 'package:shopsphere/data/repositories/authentication_repository.dart';
import 'package:shopsphere/utils/constant/image_string.dart';
import 'package:shopsphere/utils/constant/text_strings.dart';
import 'package:shopsphere/utils/popups/snackbar_helpers.dart';

class VerifyEmailController extends GetxController {

  static VerifyEmailController get instance => Get.find();

  @override
  void onReady() {
    super.onReady();

    sendEmailVerification();
    setTimerForAutoRedirect();
  }

  /// funtion to verify email
  Future<void> sendEmailVerification() async {

    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      SSnackBarHelpers.successSnackBar(title: "Email send",
          message: "Please check your inbox and verify email. Check spam also");
    } catch (e) {
      SSnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  //auto redirect after email has verified
  void setTimerForAutoRedirect() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.to(() =>
            SuccessScreen(
              title: STexts.accountCreatedTitle,
              subtitle: STexts.accountCreatedSubTitle,
              image: SImages.accountCreatedImage,
              onTap: () => AuthenticationRepository.instance.screenRedirect(),
            )
        );
      }
    });
  }


  //manually check if email has verified
  Future<void> checkEmailVerifyStatus()async{
    try{
      final user= FirebaseAuth.instance.currentUser;
      if(user!=null && user.emailVerified){
        Get.to(() =>
            SuccessScreen(
              title: STexts.accountCreatedTitle,
              subtitle: STexts.accountCreatedSubTitle,
              image: SImages.accountCreatedImage,
              onTap: () => AuthenticationRepository.instance.screenRedirect(),
            )
        );
      }
    }catch(e){
      SSnackBarHelpers.errorSnackBar(title: "Error",message: e.toString());
    }

  }



}