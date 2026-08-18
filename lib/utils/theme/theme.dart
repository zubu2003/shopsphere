import 'package:flutter/material.dart';
import 'package:shopsphere/utils/theme/customTheme/appbar_theme.dart';
import 'package:shopsphere/utils/theme/customTheme/checkbox_theme.dart';
import 'package:shopsphere/utils/theme/customTheme/chip_theme.dart';
import 'package:shopsphere/utils/theme/customTheme/elevated_btn_theme.dart';
import 'package:shopsphere/utils/theme/customTheme/outline_button_theme.dart';
import 'package:shopsphere/utils/theme/customTheme/text_theme.dart';

import 'customTheme/text_field_theme.dart';

class SAppTheme {
  SAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: STextTheme.lightTextTheme ,
    elevatedButtonTheme: SElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: SAppBarTheme.lightAppBarTheme,
    checkboxTheme: SCheckboxTheme.lightCheckboxTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.lightOutlinedButtonTheme,
    chipTheme: SChipTheme.lightChipTheme,
    inputDecorationTheme: STextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: STextTheme.darkTextTheme,
    elevatedButtonTheme: SElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: SAppBarTheme.darkAppBarTheme,
    checkboxTheme: SCheckboxTheme.darkCheckboxTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.darkOutlinedButtonTheme,
    chipTheme: SChipTheme.darkChipTheme,
    inputDecorationTheme: STextFormFieldTheme.darkInputDecorationTheme,
  );
}