import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopsphere/data/repositories/authentication_repository.dart';
import 'package:shopsphere/data/services/cloudinary_services.dart';
import 'package:shopsphere/features/authentication/models/user_model.dart';
import 'package:shopsphere/utils/constant/api.dart';
import 'package:shopsphere/utils/constant/keys.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import 'package:dio/dio.dart' as dio;

class UserRepository extends GetxController{

  static UserRepository get instance =>Get.find();

  //variable
  final _db=FirebaseFirestore.instance;
  final _cloudinaryServices= Get.put(CloudinaryServices());

  ///[Create]function to store user data
  Future<void> saveUserRecord (UserModel user)async{

    try{

      await _db.collection(SKeys.userCollection).doc(user.id).set(user.toJson());


    } on FirebaseAuthException catch(e){
      throw SFirebaseAuthException(e.code).message;
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

  ///[ReadUserData]---function to fetch user data
  Future<UserModel> fetchUserRecord ()async{

    try{

    final documentSnapShot=await _db.collection(SKeys.userCollection).doc(AuthenticationRepository.instance.currentUSer!.uid).get();

    if(documentSnapShot.exists) {
      UserModel user = UserModel.fromSnapshot(documentSnapShot);
      return user;
    }

    return UserModel.empty();

    } on FirebaseAuthException catch(e){
      throw SFirebaseAuthException(e.code).message;
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


  /// [Update] -- function to update user single field
  Future<void> updateSingleField (Map<String, dynamic> map)async{

    try{

      await _db.collection(SKeys.userCollection).doc(AuthenticationRepository.instance.currentUSer!.uid).update(map);

    } on FirebaseAuthException catch(e){
      throw SFirebaseAuthException(e.code).message;
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

  /// [Delete] --function to delete user record
  Future<void> deleteUserRecord (String userId)async{
    try{
      await _db.collection(SKeys.userCollection).doc(userId).delete();

    } on FirebaseAuthException catch(e){
      throw SFirebaseAuthException(e.code).message;
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

  Future<dio.Response> uploadImage(File image)async{
    try{


      dio.Response response=await _cloudinaryServices.uploadImage(image, SKeys.profileFolder);

      return response;

    }catch (e)  {
      throw 'failed to upload image';
    }
  }

  Future<dio.Response> deleteProfilePicture(String publicId)async{
    try{

     

      dio.Response response= await _cloudinaryServices.deleteImage(publicId);

      return response;


    }catch(e){
      throw 'Something went wrong';
    }
  }


}