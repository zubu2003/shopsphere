import 'package:flutter/material.dart';

import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';
import '../../utils/helper/helper_functions.dart';
import '../custom_shapes/circular_shape.dart';
import '../images/circular_image.dart';
class SVerticalImageText extends StatelessWidget {
  const SVerticalImageText({
    super.key, required this.title, required this.image, this.backgroundColor, required this.textColor, required this.onTap,
  });

  final String title,image;
  final Color? backgroundColor;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    return GestureDetector(
          onTap: onTap,
          //circular image
          child: Column(
            children: [
              //circular image
              SCircularImage(
                height: 56,
                width: 56,
                image: image,
                isNetworkImage: true,
              ),

              SizedBox(height: SSize.spaceBtwItems/4,),

              SizedBox(
                width:55,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium!
                      .copyWith(color:textColor),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),





    );


  }
}