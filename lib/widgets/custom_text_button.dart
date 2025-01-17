import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final Function()? onPress;
  final Widget child;
  final ButtonStyle? buttonStyle;

  const CustomTextButton(
      {super.key,
      required this.child,
      required this.onPress,
      this.buttonStyle});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      style: buttonStyle,
      child: child,
    );
  }
}
