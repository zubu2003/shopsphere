import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart' as dio hide Response;
import 'package:image_picker/image_picker.dart';
import 'package:shopsphere/data/repositories/authentication_repository.dart';
import 'package:shopsphere/data/repositories/user/user_repository.dart';
import 'package:shopsphere/features/authentication/models/user_model.dart';
import 'package:shopsphere/features/authentication/screens/login/login.dart';
import 'package:shopsphere/features/personalization/screens/edit_profile/widgets/re_authenticate_user_form.dart';
import 'package:shopsphere/utils/constant/colors.dart';
import 'package:shopsphere/utils/constant/size.dart';
import 'package:shopsphere/utils/popups/full_screen_loader.dart';
import 'package:shopsphere/utils/popups/snackbar_helpers.dart';

import '../../../utils/helper/network_manager.dart';
import 'package:dio/dio.dart' as dio;


class UserController extends GetxController{

  static UserController get instance => Get.find();

  /// Variables
  final _userRepository=Get.put(UserRepository());
  Rx<UserModel> user=UserModel.empty().obs;
  RxBool profileLoading=false.obs;
  RxBool isProfileUploading=false.obs;

  //re-authenticate variables
  final email = TextEditingController();
  final password = TextEditingController();
  final reAuthFormKey = GlobalKey<FormState>();
  RxBool isPasswordVisible=false.obs;


  @override
  void onInit() {
    fetchUserRecord();
    super.onInit();
  }

  /// function to save user record [convert credential to usermodel]
  Future<void> saveUserRecord(UserCredential userCredential)async{
    try{

      await fetchUserRecord();

      if(user.value.id.isEmpty){

        //convert full name to first and last name
        final nameParts= UserModel.nameParts(userCredential.user!.displayName);
        final userName= UserModel.generateUsername(nameParts[0], "");

        UserModel userModel=UserModel(
          id: userCredential.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length>1 ? nameParts.sublist(1).join(' '): '',
          username: userName,
          email: userCredential.user!.email ??'',
          phoneNumber: userCredential.user!.phoneNumber??'',
          profilePicture: userCredential.user!.photoURL??'',
        );

        await _userRepository.saveUserRecord(userModel);
      }

    }catch(e){
      SSnackBarHelpers.errorSnackBar(title: "Error",message: e.toString());
    }
  }


  /// function to fetch user details
  Future<void> fetchUserRecord()async{
    try{
      profileLoading.value=true;
     UserModel user = await _userRepository.fetchUserRecord();
     this.user.value=user;

    }catch(e){
      user(UserModel.empty());
    }finally{
      profileLoading.value=false;
    }
  }

  // show delete popoup dialogue box
  void deleteAccountPopoup(){
    Get.defaultDialog(
      title: 'Delete Account',
      middleText: 'Do you want to delete your account?',
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: BorderSide(
            color: Colors.red,
          )
        ),
          onPressed:()=> deleteUserAccount(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SSize.lg),
            child: Text('Yes'),
          )),
      cancel: OutlinedButton(onPressed:()=> Get.back(), child: Text('cancel')),

    );
  }

  // [DeleteAccount] -- function to delete user from firebase and firestore
  Future<void> deleteUserAccount()async{
    try{
      //start loading
      SFullScreenLoader.openLoadingDialog("Processing....");

      //re-aunthenticate user
      final authRepository=AuthenticationRepository.instance;
      final provider= authRepository.currentUSer?.providerData.map((e)=> e.providerId).first;

      //if email pass or google
      if(provider=='google.com'){
        await authRepository.signInWithGoogle();
        await authRepository.deleteUser();
        SFullScreenLoader.stopLoading();
        Get.offAll(()=> LoginScreen());

      }else if(provider=='password'){
        SFullScreenLoader.stopLoading();
        Get.to(()=>ReAuthenticateUserFormScreen());
      }


    }catch(e){

    }
  }

  Future<void> reAuthenticateUser() async {
    try {      // Start Loading
      SFullScreenLoader.openLoadingDialog('Processing ... ');

      debugPrint("3. Checking Internet");
      // Check Internet Connectivity
      bool isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        SFullScreenLoader.stopLoading();

        SSnackBarHelpers.warningSnackBar(
          title: 'No Internet Connection',
        );

        return;
      }

      // Form Validation
      if (!reAuthFormKey.currentState !.validate()) {
        debugPrint("Opening form");
        SFullScreenLoader.stopLoading();
        return;
      }
      
      await AuthenticationRepository.instance.reAuthenticaUser(email.text.trim(), password.text.trim());
      await AuthenticationRepository.instance.deleteUser();

      SFullScreenLoader.stopLoading();

      //redirect to loign
      Get.to(()=> LoginScreen());





    } catch (e) {
      SFullScreenLoader.stopLoading();
      SSnackBarHelpers.errorSnackBar(title: "Error",message: e.toString());
    }
  }

  Future<void> updateUserProfilePicture() async{
    try{
      //start loading
      isProfileUploading.value=true;

      //pick image from gallery
      XFile? image= await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image==null)return;

      //covert XFile to file
      File file=File(image.path);

      //delete profile picture if previously have any
      if(user.value.publicId.isNotEmpty){
        await _userRepository.deleteProfilePicture(user.value.publicId);
      }

      //Upload profile picture to cloudinary
     dio.Response response = await _userRepository.uploadImage(file);

     if(response.statusCode==200){

       final data= response.data;
       final imageUrl=data['secure_url'];
       final publicId=data['public_id'];

      await _userRepository.updateSingleField({
        'profilePicture': imageUrl,
        'publicId': publicId,
      });

      user.value.profilePicture=imageUrl;
      user.value.publicId=publicId;

      user.refresh();

      SSnackBarHelpers.successSnackBar(title: "Congratulations!",message: 'You have updated your profile picture');


     }else{
       throw 'Failed to upload an profile picture. Please try again';
     }


    }catch(e){
      SSnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
    }finally{
      isProfileUploading.value=false;
    }
  }

}