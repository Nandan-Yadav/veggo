import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Color? focusedColor;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.focusedColor,
  });

  @override
  Widget build(BuildContext context) {
    return
        Checkbox(
          value: value,
          onChanged: onChanged,
          focusColor: focusedColor,
        );
  }
}
