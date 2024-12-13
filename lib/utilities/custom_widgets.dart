import 'package:flutter/material.dart';

enum AppColors {
  green(0xFF388E3C),
  midGreen(0x8bbb8a),
  lightGreen(0xFFD8E8D7);

  final int value;
  const AppColors(this.value);
  Color get color => Color(value);
}

Widget reUsableTextWidget({
  required String text,
  Color? textColor,
  double fontSize = 20,
  FontWeight? fontWeight,
  TextStyle? textStyle,
}) {
  return Text(
    text,
     style:  textStyle ?? TextStyle(
      fontSize: fontSize,
      color: textColor,
      fontWeight: fontWeight,
    ),
    textAlign: TextAlign.center,
  );
}

Widget reUsableTextButton({
  required String text,
  required void Function() onPress,
  Color? backgroundColor,
  Color? foregroundColor,
  double fontSize = 20,
  double verticalPadding = 12,
}) {
  return TextButton(
    onPressed: onPress,
    child: Text(text,
        style: TextStyle(fontSize: fontSize), overflow: TextOverflow.visible),
  );
}

Widget reUsableFormField({
  required TextEditingController controller,
  required String labelText,
  required TextInputType keyboardType,
  required String? Function(String?)? validator,
  IconData? suffixIcon,
}) {
  final focusNode = FocusNode();

  return StatefulBuilder(
    builder: (context, setState) {
      return Focus(
        focusNode: focusNode,
        onFocusChange: (isFocused) {
          setState(() {});
        },
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          cursorColor: AppColors.green.color,
          decoration: InputDecoration(
            labelText: labelText,
            suffixIcon: suffixIcon != null
                ? Icon(
                    suffixIcon,
                    color: focusNode.hasFocus
                        ? AppColors.green.color
                        : Colors.grey,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.green.color),
            ),
          ),
          validator: validator,
        ),
      );
    },
  );
}
