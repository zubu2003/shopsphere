import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopsphere/features/authentication/screens/login/login.dart';

class onboardingController extends GetxController{

  static onboardingController get instance => Get.find();
  final storage=GetStorage();

  final pageController =PageController();
  RxInt currentIndex= 0.obs;

  void updatePageIndicator(index){
    currentIndex.value=index;
  }

  void dotNavigationClick(index){
    currentIndex.value=index;
    pageController.jumpToPage(index);
  }

  void nextButtonClick(){
    if(currentIndex.value==2){
      storage.write('isFirstTime', false);
      Get.offAll( ()=> LoginScreen());
      return;
    }
    currentIndex.value++;
    pageController.jumpToPage(currentIndex.value);

  }

  void skipButtonClick(){
    currentIndex.value=2;
    pageController.jumpToPage(currentIndex.value);
  }

}