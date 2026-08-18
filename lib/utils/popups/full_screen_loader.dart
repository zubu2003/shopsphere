import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/loaders/animation_loader.dart';
import '../constant/colors.dart';
import '../helper/helper_functions.dart';

class SFullScreenLoader {
  static void openLoadingDialog(String text) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
              color: SHelperFunctions.isDarkMode(Get.context!) ? SColors.dark : SColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  /// Extra Space
                  const SizedBox(height: 250),

                  /// Animation
                  SAnimationLoader(text: text)
                ],
              ),
            )));
  }

  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
