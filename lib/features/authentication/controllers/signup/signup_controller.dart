import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/data/repositories/authentication_repository.dart';
import 'package:shopsphere/data/repositories/user/user_repository.dart';
import 'package:shopsphere/features/authentication/models/user_model.dart';
import 'package:shopsphere/features/authentication/screens/signup/verify_email.dart';
import 'package:shopsphere/utils/helper/network_manager.dart';
import 'package:shopsphere/utils/popups/full_screen_loader.dart';
import 'package:shopsphere/utils/popups/snackbar_helpers.dart';

class SignupController extends GetxController {

  static SignupController get instance => Get.find();

  ///variable
  final signupFormKey=GlobalKey<FormState>();
  RxBool isPasswordVisible=false.obs;
  RxBool privacyPolicy=false.obs;

  final firstName=TextEditingController();
  final lastName=TextEditingController();
  final email=TextEditingController();
  final phoneNumber=TextEditingController();
  final password=TextEditingController();

  //username generate by random number
  String _generateUsername(String firstName, String lastName) {
    final random = Random();
    final number = random.nextInt(9000) + 1000;

    return "${firstName.toLowerCase()}${lastName.toLowerCase()}$number";
  }


  //fucntion to reg user with email and password
  Future<void> registerUser() async{

    try{
      //start loading
      SFullScreenLoader.openLoadingDialog("We are processing your information...");

      //connection check
      bool isConnected=await Get.put(NetworkManager()).isConnected();
      if(!isConnected){
        SFullScreenLoader.stopLoading();
        SSnackBarHelpers.warningSnackBar(title: "No internet connection");
        return;

      }

      //form validation
      if (!signupFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }
      //check privacy policy
      if(!privacyPolicy.value){
        SFullScreenLoader.stopLoading();
        SSnackBarHelpers.warningSnackBar(title: "Accept Privacy Policy",message: "In order to create account you have to accept privacy policy");
        return;
      }

      //register the user
      UserCredential userCredential= await AuthenticationRepository.instance.registerUser(email.text.trim(),password.text.trim());

      //create user model
      UserModel userModel=UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text,
          lastName: lastName.text,
          username: UserModel.generateUsername(firstName.text.trim(),""),
          email: email.text,
          phoneNumber: phoneNumber.text,
          profilePicture: '',
      );
      
      //save user record
      final userRepository=Get.put(UserRepository());

      await userRepository.saveUserRecord(userModel);
      
      //success message
      SSnackBarHelpers.successSnackBar(
          title: "Congratulations!",
          message:"Your account has been created. Verify you emal to continue"
      );

      //stop loading
      SFullScreenLoader.stopLoading();

      //redirect to verify email
      Get.to(()=>VerifyEmailScreen(email: email.text,));


    }catch (e, s) {
      SFullScreenLoader.stopLoading();

      debugPrint("ERROR: $e");
      debugPrintStack(stackTrace: s);

      SSnackBarHelpers.errorSnackBar(
        title: "Signup Failed",
        message: e.toString(),
      );
    }
  }


}