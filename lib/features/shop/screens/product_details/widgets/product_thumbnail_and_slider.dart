import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../../../../common/appbar/SAppbar.dart';
import '../../../../../common/icon/circular_icon.dart';
import '../../../../../common/images/SRouundImage.dart';
import '../../../../../common/product/favourite/favourite_icon.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/image_string.dart';
import '../../../../../utils/constant/size.dart';
import '../../../controllers/product/image_controller.dart';
import '../../../models/product_model.dart';

class SProductThumbnailAndSlider extends StatelessWidget {
  const SProductThumbnailAndSlider({
    super.key, required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {

  final imageController=Get.put(ImageController());
  List<String> images=imageController.getAllProductImages(product);

  final bool dark=SHelperFunctions.isDarkMode(context);
    return Container(
      color: dark? SColors.darkGrey: SColors.light,
      child: Stack(
        children: [
          //image
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(SSize.productImageRadius * 2),
                child: Center(child: Center(
                    child: Obx(
                        (){
                          final image=imageController.selectedProductImage.value;
                          return GestureDetector(
                            onTap: ()=> imageController.showEnlargeImage(image),
                            child: CachedNetworkImage(
                              imageUrl: image,
                              progressIndicatorBuilder: (context,url,progress)=>CircularProgressIndicator(color: SColors.primary,value: progress.progress,),
                            ),
                          );
                        }
                    ),
                )
              ),
            ),
          ),
          //slider image
          Positioned(
            left: SSize.defaultSpace,
            right: 0,
            bottom: 30,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                itemCount: images.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context,index)=>SizedBox(width: SSize.spaceBtwItems,) ,
                itemBuilder: (context,index)=> Obx(
                    (){
                      bool isImageSelected = imageController.selectedProductImage.value == images[index];
                      return SRoundedImage(
                        width: 80,
                        isNetworkImage: true,
                        onTap:()=> imageController.selectedProductImage.value=images[index],
                        backgroundColor: dark? SColors.dark: SColors.white,
                        padding: EdgeInsets.all(SSize.sm),
                        border: Border.all(color: isImageSelected?  SColors.primary: Colors.transparent),
                        imageUrl: images[index],
                      );
                    }
                )
              ),
            ),
          ),

          //appbar
          SAppBar(
            showLeading: true,
            actions: [SFavouriteIcon(productId: product.id,),],
          ),

        ],
      ),
    );
  }
}
