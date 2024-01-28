import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/buttons.dart';
import 'package:pawcontrol/constants/colors.dart';

class TextInputFields extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextEditingController? controller;

  const TextInputFields({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Container(
        height: ButtonStyles.buttonHeightLogin,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: ColorsApp.grey300,
              blurRadius: 25,
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorsApp.grey300,
            hintText: hintText,
            prefixIcon: prefixIcon,
            contentPadding: EdgeInsets.symmetric(vertical: 12.0),
            enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent, // Establece un borde transparente
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent, // Establece un borde transparente
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),

          ),
        ),
      ),
    );
  }
}