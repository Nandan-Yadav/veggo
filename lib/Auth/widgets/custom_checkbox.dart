import 'package:flutter/material.dart';
import 'package:veggo/Auth/widgets/custom_rich_text.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String labelText;
  final String linkText;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.labelText,
    required this.linkText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        RichTexWithTextButton(
          text: labelText,
          linkText: linkText,
          onLinkTap: () {
            // Handle link tap if necessary
          },
        ),
      ],
    );
  }
}
