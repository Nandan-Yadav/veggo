import 'package:flutter/material.dart';
import 'package:veggo/utilities/themes/custom_theme/appbar_theme.dart';
import 'package:veggo/utilities/themes/custom_theme/bottomsheet_theme.dart';
import 'package:veggo/utilities/themes/custom_theme/checkbox_theme.dart';
import 'package:veggo/utilities/themes/custom_theme/chip_theme.dart';
import 'package:veggo/utilities/themes/custom_theme/elevatedbutton_theme.dart';
import 'package:veggo/utilities/themes/custom_theme/outlinedbutton_theme.dart';
import 'package:veggo/utilities/themes/custom_theme/textbutton_theme.dart';
import 'package:veggo/utilities/themes/custom_theme/textfield_theme.dart';
import 'custom_theme/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: const Color(0xFF388E3C),
      scaffoldBackgroundColor: Colors.white,
      textTheme: CTextTheme.lightTextTheme,
      bottomSheetTheme: CBottomSheetTheme.lightBottomSheetTheme,
      appBarTheme: CAppBarTheme.lightAppBarTheme,
      checkboxTheme: CCheckboxTheme.lightCheckboxTheme,
      chipTheme: CChipTheme.lightChipTheme,
      elevatedButtonTheme: CElevatedButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: COutlinedButtonTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: CTextFormFieldTheme.lightInputDecorationTheme,
      textButtonTheme: CTextButtonTheme.lightTextButtonTheme);

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF388E3C),
      scaffoldBackgroundColor: Colors.black,
      textTheme: CTextTheme.darkTextTheme,
      bottomSheetTheme: CBottomSheetTheme.darkBottomSheetTheme,
      appBarTheme: CAppBarTheme.darkAppBarTheme,
      checkboxTheme: CCheckboxTheme.darkCheckboxTheme,
      chipTheme: CChipTheme.darkChipTheme,
      elevatedButtonTheme: CElevatedButtonTheme.darktElevatedButtonTheme,
      outlinedButtonTheme: COutlinedButtonTheme.darkOutlinedButtonTheme,
      inputDecorationTheme: CTextFormFieldTheme.darkInputDecorationTheme,
      textButtonTheme: CTextButtonTheme.lightTextButtonTheme);
}
