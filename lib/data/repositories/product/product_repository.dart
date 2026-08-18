import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart'as dio;
import 'package:shopsphere/data/services/cloudinary_services.dart';
import 'package:shopsphere/features/shop/models/product_model.dart';

import '../../../utils/constant/keys.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/helper/helper_functions.dart';

class ProductRepository extends GetxController{

  static ProductRepository get instance => Get.find();

  ///variable
  final _db= FirebaseFirestore.instance;
  CloudinaryServices get _cloudinaryServices => CloudinaryServices.instance;

  /// [Upload]
  Future<void> uploadProduct(List<ProductModel> products)async{
    try{

      //convert asset to file


      for(ProductModel product in products){


        final Map<String, String> uploadImageMap={};


        // Save original thumbnail path
        final String originalThumbnail = product.thumbnail;

        File thumbnailFile=await SHelperFunctions.assetToFile(product.thumbnail);

        //upload to cloudinary
         dio.Response response=await _cloudinaryServices.uploadImage(thumbnailFile, SKeys.productFolder);

        if(response.statusCode==200){
          String url=response.data['secure_url'];
          uploadImageMap[product.thumbnail]=url;
          product.thumbnail =url;
        }

        //upload product images
        if(product.images !=null && product.images!.isNotEmpty){
          List<String> imageUrls=[];

          for (String image in product.images!){
            File imageFile= await SHelperFunctions.assetToFile(image);
            dio.Response response =await _cloudinaryServices.uploadImage(imageFile, SKeys.productFolder);

            if(response.statusCode==200){
              imageUrls.add(response.data['secure_url']);
            }
          }

          // Upload product variation images
          if (product.productVariations != null &&
              product.productVariations!.isNotEmpty) {

            for (int i = 0; i < product.images!.length; i++) {
              uploadImageMap[product.images![i]] = imageUrls[i];
            }

            for (final variation in product.productVariations!) {
              final match = uploadImageMap.entries.firstWhere(
                    (entry) => entry.key == variation.image,
                orElse: () => const MapEntry('', ''),
              );

              if (match.key.isNotEmpty) {
                variation.image = match.value;
              }
            }
          }

          product.images!.clear();
          product.images!.assignAll(imageUrls);
        }

        await _db.collection(SKeys.productCollection).doc(product.id).set(product.toJson());
      }

    }on SFirebaseException catch(e){
      throw SFirebaseException(e.code).message;
    }on FormatException {
      throw FormatException();
    }on SPlatformException catch(e){
      throw SPlatformException(e.code).message;
    }catch(e){
      print('PRODUCT UPLOAD ERROR: $e');
    }
  }

  /// [FetchFeatureProducts]
  Future< List<ProductModel> > fetchFeatureProducts()async{
    try{

      final query = await _db.collection(SKeys.productCollection).where('isFeatured', isEqualTo: true).limit(4).get();

      if(query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs.map((document) =>
            ProductModel.fromSnapshot(document)).toList();
        return products;
      }

    return [];


    }on SFirebaseException catch(e){
      throw SFirebaseException(e.code).message;
    }on FormatException {
      throw FormatException();
    }on SPlatformException catch(e){
      throw SPlatformException(e.code).message;
    }catch(e){
      throw e.toString();
    }
  }


}