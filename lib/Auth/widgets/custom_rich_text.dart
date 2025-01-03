import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:veggo/utilities/constants/color.dart';

class RichTexWithTextButton extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback onLinkTap;

  const RichTexWithTextButton({
    super.key,
    required this.text,
    required this.linkText,
    required this.onLinkTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: linkText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CColors.primary,),
            recognizer: TapGestureRecognizer()..onTap = onLinkTap,
          ),
        ],
      ),
    );
  }
}
