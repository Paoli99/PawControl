import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pawcontrol/constants/colors.dart';

class TextFields extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final Color? borderColor;
  final Color? backgroundColor;
  final TextInputType keyboardType;

  const TextFields({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.borderColor,
    this.backgroundColor,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color enabledBorderColor = borderColor ?? Colors.transparent;
    Color focusedBorderColor = borderColor ?? Colors.transparent;
    Color filledColor = backgroundColor ?? ColorsApp.grey300;

    List<TextInputFormatter>? inputFormatters = [];

    // Verificar si el campo no está oculto y el tipo de teclado es número sin opción decimal
    if (!obscureText && keyboardType == TextInputType.number) {
      inputFormatters.add(FilteringTextInputFormatter.digitsOnly); // Permitir solo dígitos
    }

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
          keyboardType: keyboardType,
          inputFormatters: inputFormatters.isNotEmpty ? inputFormatters : null,
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
        ),
      ),
    );
  }
}
