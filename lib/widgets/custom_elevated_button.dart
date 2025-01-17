import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function()? onPress;
  final Widget? child;
  final ButtonStyle? buttonStyle;

  const CustomElevatedButton(
      {super.key,
      required this.child,
      required this.onPress,
      this.buttonStyle});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: buttonStyle,
      child: child,
    );
  }
}