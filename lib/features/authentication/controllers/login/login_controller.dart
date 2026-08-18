import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopsphere/data/repositories/authentication_repository.dart';
import 'package:shopsphere/features/personalization/controllers/user_controller.dart';
import 'package:shopsphere/utils/constant/keys.dart';
import 'package:shopsphere/utils/helper/network_manager.dart';
import 'package:shopsphere/utils/popups/full_screen_loader.dart';
import 'package:shopsphere/utils/popups/snackbar_helpers.dart';

class LoginController extends GetxController{

  static LoginController get instance => Get.find();

  ///variables
   final _userController=Get.put(UserController());

   final email=TextEditingController();
   final password=TextEditingController();
   RxBool isPasswordVisible=false.obs;
   RxBool rememberMe=false.obs;
   final loginFormKey=GlobalKey<FormState>();

   final localStorage=GetStorage();


  @override
  void onInit() {
   email.text=localStorage.read(SKeys.rememberMeEmail)?? '';
   password.text=localStorage.read(SKeys.rememberMePassword)?? '';
   rememberMe.value=localStorage.read(SKeys.rememberMeCheckbox)?? false;
   super.onInit();
  }

  /// Function to login with email and password
  Future<void> loginWithEmailAndPassword()async{

    try{

     SFullScreenLoader.openLoadingDialog("Logging you in....");

     // validation
     if(!loginFormKey.currentState!.validate()){
      SFullScreenLoader.stopLoading();
      return;
     }

     //checking network
     final isConnected= await NetworkManager.instance.isConnected();
     if(!isConnected){
      SFullScreenLoader.stopLoading();
      SSnackBarHelpers.warningSnackBar(title: "No internet connection");
      return;
     }

     //remember email and password
     if(rememberMe.value){
      localStorage.write(SKeys.rememberMeEmail, email.text.trim());
      localStorage.write(SKeys.rememberMePassword, password.text.trim());
      localStorage.write(SKeys.rememberMeCheckbox,true);
     }

    //login with email and password
     await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

     //stop loading
     SFullScreenLoader.stopLoading();

     //redirect
     AuthenticationRepository.instance.screenRedirect();


    }catch(e){

     SFullScreenLoader.stopLoading();
     SSnackBarHelpers.errorSnackBar(title: "Error",message: e.toString());

    }

   }

  ///Function to Sign in with google
  Future<void> googleSignIn()async{

    try{
      //start loading
      SFullScreenLoader.openLoadingDialog("Logging you in....");

      //checking network
      final isConnected= await NetworkManager.instance.isConnected();
      if(!isConnected){
        SFullScreenLoader.stopLoading();
        SSnackBarHelpers.warningSnackBar(title: "No internet connection");
        return;
      }

      //google authentication
      UserCredential userCredential= await AuthenticationRepository.instance.signInWithGoogle();

      //save user record
      _userController.saveUserRecord(userCredential);

      //stop loading
      SFullScreenLoader.stopLoading();

      //reddirect
      AuthenticationRepository.instance.screenRedirect();


    }catch(e){
      SFullScreenLoader.stopLoading();
      SSnackBarHelpers.errorSnackBar(title: "Error",message: e.toString());
    }

  }

}
