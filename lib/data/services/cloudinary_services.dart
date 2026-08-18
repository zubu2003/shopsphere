import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart'as dio;

import '../../utils/constant/api.dart';
import '../../utils/constant/keys.dart';

class CloudinaryServices extends GetxController{

  static CloudinaryServices get instance => Get.find();

  /// varibles
  final _dio= dio.Dio();

  ///[UploadImage] - function to upload image

  Future<dio.Response> uploadImage(File image,String foldername)async{
    try{
      String api=SApiUrls.uploadApi(SKeys.cloudname);
      dio.FormData formData =dio.FormData.fromMap({
        'upload_preset': SKeys.uploadPreset,
        'folder': foldername,
        'file':await dio.MultipartFile.fromFile(image.path, filename: image.path.split('/').last)
      });

      dio.Response response=await dio.Dio().post(api,data:formData);

      return response;

    }catch (e)  {
      throw 'failed to upload image';
    }
  }



  ///[DeleteImage] - function to upload image
  Future<dio.Response> deleteImage(String publicId)async{
    try{

      String api=SApiUrls.deleteApi(SKeys.cloudname);

      int timeStamp= (DateTime.now().microsecondsSinceEpoch /1000 ).round();
      String signatureBase= 'public_id=$publicId&timestamp=$timeStamp${SKeys.apiSecret}';
      String signature = sha1.convert(utf8.encode(signatureBase)).toString();

      final formData=  dio.FormData.fromMap({
        'public_id': publicId,
        'api_key': SKeys.apiKey,
        'timestamp': timeStamp,
        'signature': signature,
      });

      dio.Response response= await dio.Dio().post(api,data: formData);

      return response;


    }catch(e){
      throw 'Something went wrong';
    }
  }



}