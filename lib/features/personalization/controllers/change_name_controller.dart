import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/data/repositories/user/user_repository.dart';
import 'package:shopsphere/features/personalization/controllers/user_controller.dart';

import '../../../utils/helper/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/snackbar_helpers.dart';

class ChangeNameController extends GetxController{

  static ChangeNameController get instance => Get.find();

  //variables
  final _userController=UserController.instance;
  final _userRepository=UserRepository.instance;

  final firstName=TextEditingController();
  final lastName=TextEditingController();

  //form key
  final updateNameFormKey=GlobalKey<FormState>();

  @override
  void onInit() {
    initializedNames();
    super.onInit();
  }

  void initializedNames(){
    firstName.text=_userController.user.value.firstName;
    lastName.text=_userController.user.value.lastName;
  }

  //fucntion to update name
  Future<void> updateUserName()async{
    try{

      SFullScreenLoader.openLoadingDialog("Processing your request....");

      // validation
      if(!updateNameFormKey.currentState!.validate()){
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

      //update user name from fire store
      Map<String,dynamic> map={'firstName': firstName.text,'lastName': lastName.text};
      await _userRepository.updateSingleField(map);

      //update from rx user
      _userController.user.value.firstName=firstName.text;
      _userController.user.value.lastName=lastName.text;
      
      //stop loading
      SFullScreenLoader.stopLoading();
      
      //succes message
      SSnackBarHelpers.successSnackBar(title: "Congratulations",message: "your name has been updated");


    }catch(e){
      SFullScreenLoader.stopLoading();
      SSnackBarHelpers.errorSnackBar(title: "Error",message: e.toString());
    }
  }
}