import 'package:flutter/material.dart';
import 'package:veggo/utilities/constants/color.dart';
import 'package:veggo/utilities/constants/size.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? labelText;
  final String? hintText;
  final Widget? prefix;
  final String? Function(String?)? validator;
  final Color? prefixIconColor;
  final FocusNode? focusNode;

  const CustomFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    this.labelText,
    this.hintText,
    this.prefix,
    this.validator,
    this.prefixIconColor,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintAndLableStyle(context),
        label: labelText != null ? Text(labelText!) : null,
        labelStyle: hintAndLableStyle(context),
        prefixIcon: prefix,
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
  
  TextStyle? hintAndLableStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall?.copyWith(
      fontSize: CSizes.fontSizeMd,
    );
  }

}
