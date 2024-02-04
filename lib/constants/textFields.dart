import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pawcontrol/constants/buttons.dart';
import 'package:pawcontrol/constants/colors.dart';

class TextFields extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final Color? borderColor;
  final Color? backgroundColor;

  const TextFields({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.borderColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color enabledBorderColor = borderColor ?? Colors.transparent;
    Color focusedBorderColor = borderColor ?? Colors.transparent;
    Color filledColor = backgroundColor ?? ColorsApp.grey300;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Container(
        decoration: BoxDecoration(
          color: filledColor,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: ColorsApp.grey300,
              blurRadius: 25,
            ),
          ],
          border: borderColor != null ? Border.all(color: borderColor!, width: 1.0) : null,
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: filledColor,
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(vertical: 12.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: enabledBorderColor),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focusedBorderColor),
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(8),
          ],
        ),
      ),
    );
  }
}
