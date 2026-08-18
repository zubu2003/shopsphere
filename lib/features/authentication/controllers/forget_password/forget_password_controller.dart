import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/data/repositories/authentication_repository.dart';
import 'package:shopsphere/features/authentication/screens/forget_pass/reset_pass_screen.dart';
import 'package:shopsphere/utils/popups/full_screen_loader.dart';

import '../../../../utils/helper/network_manager.dart';
import '../../../../utils/popups/snackbar_helpers.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  //variables
  final email=TextEditingController();
  final forgetPasswordFormKey=GlobalKey<FormState>();

  //send email to reset passwpord
  Future<void> sendPasswordResetEmail()async{
    try{

      //start loading
      SFullScreenLoader.openLoadingDialog("Processing your request......");

      //checking network
      final isConnected= await NetworkManager.instance.isConnected();
      if(!isConnected){
        SFullScreenLoader.stopLoading();
        SSnackBarHelpers.warningSnackBar(title: "No internet connection");
        return;
      }

      //form validation
      if(!forgetPasswordFormKey.currentState!.validate()){
        SFullScreenLoader.stopLoading();
        return;
      }

      //send password reset email
      AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      //stop loading
      SFullScreenLoader.stopLoading();

      //succes message
      SSnackBarHelpers.successSnackBar(title: "Email sent",message: "Your password reset email has been sent. Check your inbox and spam also");

      Get.to(()=> ResetPasswordScreen());

    }catch(e){
      SFullScreenLoader.stopLoading();
      SSnackBarHelpers.errorSnackBar(title: "Failed forget password",message: e.toString());
    }
  }

  //resend email to reset passwpord
  Future<void> resendPasswordResetEmail()async{
    try{

      //start loading
      SFullScreenLoader.openLoadingDialog("Processing your request......");

      //checking network
      final isConnected= await NetworkManager.instance.isConnected();
      if(!isConnected){
        SFullScreenLoader.stopLoading();
        SSnackBarHelpers.warningSnackBar(title: "No internet connection");
        return;
      }

      //send password reset email
      AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      //stop loading
      SFullScreenLoader.stopLoading();

      //succes message
      SSnackBarHelpers.successSnackBar(title: "Email sent",message: "Your password reset email has been sent. Check your inbox and spam also");

    }catch(e){
      SFullScreenLoader.stopLoading();
      SSnackBarHelpers.errorSnackBar(title: "Failed forget password",message: e.toString());
    }
  }




}