import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/data/services/cloudinary_services.dart';
import 'package:shopsphere/features/shop/models/banners_model.dart';
import 'package:shopsphere/utils/constant/keys.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';
import 'package:dio/dio.dart'as dio;
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class BannerRepository extends GetxController{

  static BannerRepository get instance => Get.find();

  ///variable
  final _db=FirebaseFirestore.instance;
  final _cloudinaryServices=Get.put(CloudinaryServices());


  Future<void> uploadBanner(List<BannerModel> banners)async{
    try{

      //convert asset to file

      for(final banner in banners){
        File image=await SHelperFunctions.assetToFile(banner.imageUrl);
        dio.Response response= await _cloudinaryServices.uploadImage(image, SKeys.bannerFolder);

        if(response.statusCode==200){
          banner.imageUrl=response.data['secure_url'];
        }

        await _db.collection(SKeys.bannerCollection).doc().set(banner.toJson());
      }

    }on SFirebaseException catch(e){
      throw SFirebaseException(e.code).message;
    }on FormatException {
      throw FormatException();
    }on SPlatformException catch(e){
      throw SPlatformException(e.code).message;
    }catch(e){
      throw "Something went wrong";
    }
  }

  Future<List<BannerModel>> fetchActiveBanner()async{
    try{

      final query=await _db.collection(SKeys.bannerCollection).where('active',isEqualTo: true).get();
      if(query.docs.isNotEmpty){
        List<BannerModel> banners=query.docs.map((document)=>BannerModel.fromDocument(document)).toList();
        return banners;
      }
      return [];

    }on SFirebaseException catch(e){
      throw SFirebaseException(e.code).message;
    }on FormatException {
      throw FormatException();
    }on SPlatformException catch(e){
      throw SPlatformException(e.code).message;
    }catch(e){
      throw "Something went wrong";
    }
  }

}