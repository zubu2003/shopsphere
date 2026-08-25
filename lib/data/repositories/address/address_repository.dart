import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopsphere/utils/constant/keys.dart';
import '../../../features/personalization/models/address_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../authentication_repository.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  /// Variables
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///[Upload] Function to store user address
  Future<String> addAddress(AddressModel address) async {
    try {
      final userId =AuthenticationRepository.instance.currentUser!.uid;

      final currentAddress =await _db.collection(SKeys.userCollection).doc(userId).collection(SKeys.addressCollection).add(address.toJson());
      return currentAddress.id;


    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while saving Address Information. Please try again.';
    }
  }

  ///[Fetch] Function to get user address
  Future<List<AddressModel>> fetchUserAddress() async {
    try {
      final userId =AuthenticationRepository.instance.currentUser!.uid;
      if(userId.isEmpty)throw "User not Found. Please try again";

      final query=await _db.collection(SKeys.userCollection).doc(userId).collection(SKeys.addressCollection).get();

      if(query.docs.isNotEmpty){
        List<AddressModel> addresses=query.docs.map((doc)=> AddressModel.fromDocumentSnapshot(doc)).toList();

        return addresses;

      }
      return [];

    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while saving Address Information. Please try again.';
    }
  }

  ///[Update] Function to update selected address
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.currentUser!.uid;

      await _db
          .collection(SKeys.userCollection)
          .doc(userId)
          .collection(SKeys.addressCollection)
          .doc(addressId)
          .update({
        'selectedAddress': selected,
      });
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while updating the selected address.';
    }
  }





}
