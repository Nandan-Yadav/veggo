import 'package:flutter/material.dart';
import 'package:veggo/utilities/constants/size.dart';

class CElevatedButtonTheme {
  CElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF388E3C),
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Color(0xFF388E3C)),
      padding: const EdgeInsets.symmetric(vertical: 18), // Ensure height consistency
      textStyle: const TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CSizes.buttonRadius)),
      minimumSize: const Size(double.infinity, 0), // Make width full screen
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF388E3C),
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Color(0xFF388E3C)),
      padding: const EdgeInsets.symmetric(vertical: 18), // Ensure height consistency
      textStyle: const TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CSizes.buttonRadius)),
      minimumSize: const Size(double.infinity, 0), // Make width full screen
    ),
  );
}
