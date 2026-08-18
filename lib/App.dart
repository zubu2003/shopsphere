import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shopsphere/bindings/bindings.dart';
import 'package:shopsphere/routes/app_routes.dart';
import 'package:shopsphere/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,

      getPages: SAppRoutes.screen,

      initialBinding: SBindings(),
      debugShowCheckedModeBanner: false,
      home: Center(
        child: CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}