import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/image_string.dart';
import '../../utils/constant/size.dart';

class SAnimationLoader extends StatelessWidget {
  final String text;
  final String animation;
  final bool showActionButton;
  final String? actionText;
  final VoidCallback? onActionPressed;
  
  


  const SAnimationLoader({
    super.key,
    required this.text,
    this.animation = SImages.loadingAnimation,
    this.showActionButton = false,
    this.actionText,
    this.onActionPressed
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Animation
          Lottie.asset(animation, width: Get.width * 0.8),
          const SizedBox(height: SSize.defaultSpace),

          /// Title
          Text(text, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          const SizedBox(height: SSize.defaultSpace),
          
          showActionButton ?
              SizedBox(
                width : 250,
                child: OutlinedButton(
                  onPressed: onActionPressed,
                    style: OutlinedButton.styleFrom(backgroundColor: SColors.dark),
                    child: Text(
                      actionText!,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(color: SColors.light),
                    ),
                )
              ) : SizedBox()
        ],
      ),
    );
  }
}
