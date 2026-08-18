
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constant/size.dart';
import '../../models/product_model.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  /// Variables
  RxString selectedProductImage = ''.obs;

  /// Function to load all images of product
  List<String> getAllProductImages(ProductModel product) {
    Set<String> images = {};

    // Load Thumbnail image
    images.add(product.thumbnail);

    // Assign Thumbnail as Selected Image
    selectedProductImage.value = product.thumbnail;

    // Load all images of product
    if (product.images != null && product.images!.isNotEmpty) {
      images.addAll(product.images!);
    }

    // Load all images from the product variations
    if (product.productVariations != null &&
        product.productVariations!.isNotEmpty) {
      List<String> variationImages = product.productVariations!
          .map((variation) => variation.image)
          .toList();

      images.addAll(variationImages);
    }

    // Return all unique images
    return images.toList();
  }

  void showEnlargeImage(String image) {
    Get.to(
      fullscreenDialog: true,
          () => Dialog.fullscreen(
        child: Column(
          children: [
            /// Image
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: SSize.defaultSpace * 2,
                horizontal: SSize.defaultSpace,
              ),
              child: CachedNetworkImage(
                imageUrl: image,
              ),
            ),

            SizedBox(height: SSize.spaceBtwSections),

            /// Close Button
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text('Close'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}