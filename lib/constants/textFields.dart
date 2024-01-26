
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/base.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';

abstract class TextosCampos {
  static double textBoxHorizonatal() {
    return 25.0;
  }

  static double textBoxVertical() {
    return 8.0;
  }

  static TextStyle text() {
    return TextsFont.cuerpo;
  }

  static TextStyle placeholder() {
    return TextsFont.suggestion;
  }

  static Color colorCursor() {
    return ColorsApp.deepPurple100;
  }

  static Widget iconPrefix(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Icon(
        icon,
        size: 35.0,
        color: ColorsApp.deepPurple100,
      ),
    );
  }

  static BoxDecoration get cupertino {
    return BoxDecoration(
        border: Border.all(
          color: ColorsApp.deepPurple100,
          width: EstilosBase.borderWidth,
        ),
        borderRadius: BorderRadius.circular(EstilosBase.borderRadius));
  }

  static TextAlign textAlign() {
    return TextAlign.center;
  }

  static BoxDecoration get cupertinoError {
    return BoxDecoration(
        border: Border.all(
          color: ColorsApp.red700,
          width: EstilosBase.borderWidth,
        ),
        borderRadius: BorderRadius.circular(EstilosBase.borderRadius));
  }

  static InputDecoration androidIcons(
      String hintText, IconData icon, String errorText) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(8.0),
      hintText: hintText,
      hintStyle: TextosCampos.placeholder(),
      border: InputBorder.none,
      errorText: errorText,
      errorStyle: TextsFont.error,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorsApp.deepPurple100, width: EstilosBase.borderWidth),
          borderRadius: BorderRadius.circular(EstilosBase.borderRadius)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorsApp.deepPurple100, width: EstilosBase.borderWidth),
          borderRadius: BorderRadius.circular(EstilosBase.borderRadius)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorsApp.deepPurple100, width: EstilosBase.borderWidth),
          borderRadius: BorderRadius.circular(EstilosBase.borderRadius)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorsApp.red700, width: EstilosBase.borderWidth),
          borderRadius: BorderRadius.circular(EstilosBase.borderRadius)),
      prefixIcon: iconPrefix(icon),
    );
  }
}