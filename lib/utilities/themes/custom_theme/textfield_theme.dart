import 'package:flutter/material.dart';
import 'package:veggo/utilities/constants/size.dart';

class CTextFormFieldTheme {
  CTextFormFieldTheme._();

  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
  ).copyWith(
    labelStyle: const TextStyle().copyWith(fontSize: 16, color: Colors.grey),
    hintStyle: const TextStyle().copyWith(fontSize: 16, color: Colors.grey),
    floatingLabelStyle: const TextStyle().copyWith(
      color: const Color(0xFF388E3C).withOpacity(0.8), 
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CSizes.inputFieldRadius),
      borderSide: const BorderSide().copyWith(width: 1, color: const Color(0xFF388E3C)),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CSizes.inputFieldRadius),
      borderSide: const BorderSide().copyWith(width: 1, color: const Color(0xFF388E3C)),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CSizes.inputFieldRadius),
      borderSide: const BorderSide().copyWith(width: 2, color: const Color(0xFF388E3C)), 
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CSizes.inputFieldRadius),
      borderSide: const BorderSide().copyWith(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CSizes.inputFieldRadius),
      borderSide: const BorderSide().copyWith(width: 2, color: Colors.red),
    ),
  );

  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
  ).copyWith(
    labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.grey),
    hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.grey),
    floatingLabelStyle: const TextStyle().copyWith(
      color: const Color(0xFF388E3C).withOpacity(0.8), 
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CSizes.inputFieldRadius),
      borderSide: const BorderSide().copyWith(width: 1, color: const Color(0xFF388E3C)),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CSizes.inputFieldRadius),
      borderSide: const BorderSide().copyWith(width: 1, color: const Color(0xFF388E3C)),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CSizes.inputFieldRadius),
      borderSide: const BorderSide().copyWith(width: 2, color: const Color(0xFF388E3C)), // Thicker border when focused
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CSizes.inputFieldRadius),
      borderSide: const BorderSide().copyWith(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CSizes.inputFieldRadius),
      borderSide: const BorderSide().copyWith(width: 2, color: Colors.red),
    ),
  );
}