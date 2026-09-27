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

  /// [FetchAllProducts]
  Future< List<ProductModel> > fetchAllProducts()async{
    try{

      final query = await _db.collection(SKeys.productCollection).get();

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

  /// [FetcAllhFeatureProducts]
  Future< List<ProductModel> > fetchALlFeatureProducts()async{
    try{

      final query = await _db.collection(SKeys.productCollection).where('isFeatured', isEqualTo: true).get();

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

  /// [FetcAllhFeatureProducts]-- by query
  Future< List<ProductModel> > fetchProductsByQuery(Query query)async{
    try{

      final querySnapshot = await query.get();

      if(querySnapshot.docs.isNotEmpty) {
        List<ProductModel> products = querySnapshot.docs.map((document) =>
            ProductModel.fromQuerySnapshot(document)).toList();
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

  /// [Fetch] - Function to fetch all list of brand specific products
  Future<List<ProductModel>> getProductsForBrand({required String brandId,int limit = -1,}) async {
    try {
      final query = limit == -1
          ? await _db
          .collection(SKeys.productCollection)
          .where('brand.id', isEqualTo: brandId)
          .get()
          : await _db
          .collection(SKeys.productCollection)
          .where('brand.id', isEqualTo: brandId)
          .limit(limit)
          .get();

      if (query.docs.isNotEmpty) {
        final products = query.docs.map((document) => ProductModel.fromSnapshot(document)).toList();

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

  /// [Fetch] - Get products for a specific category
  Future<List<ProductModel>> getProductsForCategory({required String categoryId,int limit = -1,}) async {
    try {
      // Get category-product documents
      final productCategoryQuery = limit == -1
          ? await _db
          .collection(SKeys.productCategoryCollection)
          .where('categoryId', isEqualTo: categoryId)
          .get()
          : await _db
          .collection(SKeys.productCategoryCollection)
          .where('categoryId', isEqualTo: categoryId)
          .limit(limit)
          .get();

      // Get product IDs
      final List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['productId'] as String)
          .toList();

      // Return empty list if no product IDs are found
      if (productIds.isEmpty) {
        return [];
      }

      // Get products using their document IDs
      final productQuery = await _db
          .collection(SKeys.productCollection)
          .where(
        FieldPath.documentId,
        whereIn: productIds,
      )
          .get();

      // Convert documents to ProductModel
      final List<ProductModel> products = productQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on SFirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException {
      throw FormatException();
    } on SPlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  /// [FetchFavouriteeProducts]
  Future< List<ProductModel> > getFavouriteProducts(List<String> productIds)async{
    try{

      final query = await _db.collection(SKeys.productCollection).where(FieldPath.documentId,whereIn: productIds).get();

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








