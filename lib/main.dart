import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopsphere/data/repositories/authentication_repository.dart';
import 'App.dart';
import 'firebase_options.dart';

Future<void> main() async {
  //widgets flutter binding
  final widgetsBinding=WidgetsFlutterBinding.ensureInitialized();

  //flutter native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //get storage initialization
  await GetStorage.init();

  //Firebase initialiazation-----
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  ).then((value){
    Get.put(AuthenticationRepository());
  });

  //portrait up the device
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const App());
}

