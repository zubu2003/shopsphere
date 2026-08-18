import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopsphere/data/services/cloudinary_services.dart';
import 'package:shopsphere/features/shop/models/category_model.dart';
import 'package:shopsphere/utils/constant/keys.dart';
import 'package:shopsphere/utils/helper/helper_functions.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import 'package:dio/dio.dart' as dio;

class CategoryRepository extends GetxController{

  static CategoryRepository get instance => Get.find();

  //variables
  final _db=FirebaseFirestore.instance;
  final _cloudinaryServices=Get.put(CloudinaryServices());

  ///[UploadCategory]
  Future<void> uploadCategories (List<CategoryModel> categories)async{
    try{
      for(final category in categories ){
        File image=await SHelperFunctions.assetToFile(category.image);

        dio.Response response= await _cloudinaryServices.uploadImage(image, SKeys.categoryFolder);
        if(response.statusCode==200){
          category.image= response.data['secure_url'];
        } 

        
        await _db.collection(SKeys.categoryCollection).doc(category.id).set(category.toJson());
        
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

  ///[FetchCategory]
  Future<List<CategoryModel>> getAllCategories ()async{
    try{
      final query= await _db.collection(SKeys.categoryCollection).get();
      
      if(query.docs.isNotEmpty){
        List<CategoryModel> categories= query.docs.map((document)=> CategoryModel.fromSnapshot(document)).toList();
        return categories;
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