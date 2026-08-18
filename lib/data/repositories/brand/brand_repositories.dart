import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart' as dio hide Response;
import 'package:shopsphere/features/shop/models/brand_model.dart';

import '../../../utils/constant/keys.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/helper/helper_functions.dart';
import '../../services/cloudinary_services.dart';
import 'package:dio/dio.dart'as dio;

class BrandRepository extends GetxController{

  static BrandRepository get instance => Get.find();

  /// variables
  final _db=FirebaseFirestore.instance;
  final _cloudinaryServices=Get.put(CloudinaryServices());

  /// [Upload]
  Future<void> uploadBrand(List<BrandModel> brands)async{
    try{

      //convert asset to file

      for(final brand in brands){
        File image=await SHelperFunctions.assetToFile(brand.image);

        //upload to cloudinary
        dio.Response response= await _cloudinaryServices.uploadImage(image, SKeys.brandFolder);

        if(response.statusCode==200){
          brand.image=response.data['secure_url'];
        }

        await _db.collection(SKeys.brandCollection).doc(brand.id).set(brand.toJson());

      }

    }on SFirebaseException catch(e){
      throw SFirebaseException(e.code).message;
    }on FormatException {
      throw FormatException();
    }on SPlatformException catch(e){
      throw SPlatformException(e.code).message;
    }catch(e){
      throw 'Unable to upload';
    }
  }

  /// [FetchBrand]
  Future<List<BrandModel>> fetchBrands()async{
    try{

      final query=await _db.collection(SKeys.brandCollection).get();
      if(query.docs.isNotEmpty){
        List<BrandModel> brands=query.docs.map((document)=>BrandModel.fromSnapshot(document)).toList();
        return brands;
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