import 'package:flutter/material.dart';
import 'package:veggo/utilities/constants/color.dart';
import 'package:veggo/utilities/constants/size.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final Color? prefixIconColor;
  final FocusNode focusNode;

  const CustomFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.label,
    required this.icon,
    required this.validator,
    required this.prefixIconColor,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: Text(label),
        prefixIcon: Icon(icon),
        prefixIconColor: prefixIconColor,
      ),
      cursorColor: CColors.primary,
      cursorErrorColor: CColors.error,
      validator: validator,
      style: const TextStyle(fontSize: CSizes.fontSizeLg),
      focusNode: focusNode,
      autofocus: false,
    );
  }
}
