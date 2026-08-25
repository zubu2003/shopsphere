import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopsphere/bottom_navigation.dart';
import 'package:shopsphere/data/repositories/banner/banner_repository.dart';
import 'package:shopsphere/data/repositories/brand/brand_repositories.dart';
import 'package:shopsphere/data/repositories/category/category_repository.dart';
import 'package:shopsphere/data/repositories/product/product_repository.dart';
import 'package:shopsphere/data/repositories/user/user_repository.dart';
import 'package:shopsphere/dummy_data.dart';
import 'package:shopsphere/features/authentication/screens/forget_pass/forget_password.dart';
import 'package:shopsphere/features/authentication/screens/login/login.dart';
import 'package:shopsphere/features/authentication/screens/onboarding/onboarding.dart';
import 'package:shopsphere/features/authentication/screens/signup/verify_email.dart';
import 'package:shopsphere/features/personalization/controllers/user_controller.dart';
import 'package:shopsphere/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:shopsphere/utils/exceptions/firebase_exceptions.dart';
import 'package:shopsphere/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  final localStorage=GetStorage();
  final _auth=FirebaseAuth.instance;

  //current user
  User? get currentUser=> _auth.currentUser;

  @override
  void onReady() {
    //native splash remove
    FlutterNativeSplash.remove();

    //redirect to screen
    screenRedirect();
    
    //category initialize
    //Get.put(BannerRepository()).uploadBanner(SDummyData.banner);
    //Get.put(ProductRepository().uploadProduct(SDummyData.products));


  }

  Future<void> screenRedirect()async{

    final user=_auth.currentUser;
    if(user!=null){
      if(user.emailVerified){
        Get.offAll(()=>BottomNavigationMenu());

        //initializs user specific box
        await GetStorage.init(user.uid);


      }else{
        Get.to(()=>VerifyEmailScreen(email: user.email,));
      }

    }else{

      localStorage.writeIfNull('isFirstTime', true);

      localStorage.read('isFirstTime')!=true ? Get.to(()=> LoginScreen()) : Get.to(()=>OnboardingScreen());
    }

  }


  /// [authentication] --- with email and pass sign up
  Future<UserCredential> registerUser(String email,String password)async{
    try{
      UserCredential userCredential= await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );
      return userCredential;
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

  /// [Email login] -----
  Future<UserCredential> loginWithEmailAndPassword (String email,String password)async{
    try{
      UserCredential userCredential=await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ).timeout(const Duration(seconds: 55));
      return userCredential;
    }on TimeoutException{
      throw "Connection timed out. Check your internet.";
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

  /// [Google login] -----
  Future<UserCredential> signInWithGoogle ()async{
    try{

      //get instance of google
      GoogleSignIn googleSignIn=GoogleSignIn.instance;

      //initialize google
      await googleSignIn.initialize();

      //show popup to select google account
      GoogleSignInAccount userAccount= await googleSignIn.authenticate();

      //create credentials
      final OAuthCredential credential= GoogleAuthProvider.credential(
          idToken: userAccount.authentication.idToken
      );

      //sign in using google credentials
      UserCredential userCredential= await _auth.signInWithCredential(credential);
      return userCredential;

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

  /// [EmailVerification]------
  Future<void> sendEmailVerification()async{
    try{
      await _auth.currentUser!.sendEmailVerification();
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
  /// [ForgetPassword]------
  Future<void> sendPasswordResetEmail(String email)async{
    try{

      await _auth.sendPasswordResetEmail(email: email).timeout(const Duration(seconds: 15));;
    }on TimeoutException{
      throw "Connection timed out. Check your internet.";
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

  /// [Logut]-------
  Future<void> logout() async{
    try{
      await FirebaseAuth.instance.signOut();
      Get.offAll(()=>LoginScreen());
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

  /// [DeleteUser] -------
  Future<void> deleteUser() async{
    try{
      await UserRepository.instance.deleteUserRecord(currentUser!.uid);
      String publicId=UserController.instance.user.value.publicId;
      if(publicId.isNotEmpty){
        UserRepository.instance.deleteProfilePicture(publicId);
      }
       await _auth.currentUser?.delete();

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
  /// [Reauthenticate] --function to delete user record
  Future<void> reAuthenticaUser (String email,String password)async{
    try{
      AuthCredential credential= EmailAuthProvider.credential(email: email, password: password);

      await currentUser?.reauthenticateWithCredential(credential);

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

}