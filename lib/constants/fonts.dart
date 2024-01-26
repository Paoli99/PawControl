import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pawcontrol/constants/colors.dart';

abstract class TextsFont {
  static TextStyle get tituloLogo {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
          color: ColorsApp.white, 
          fontSize: 42.0,
          fontWeight: FontWeight.bold));
  }

  //botones 

  static TextStyle get loginButton {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
          color: ColorsApp.white, 
          fontSize: 20.0,
          fontWeight: FontWeight.bold));
  }

  static TextStyle get cuerpo {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
          color: ColorsApp.grey300, 
          fontSize: 16.0));
  }

  static TextStyle get buttonTextLight  {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
          color: ColorsApp.grey800, 
          fontSize: 16.0));
  }

  static TextStyle get link {
    return GoogleFonts.roboto(
        textStyle: TextStyle(
            color: ColorsApp.lightBlue900,
            fontSize: 15.0,
            fontWeight: FontWeight.bold));
  }

  static TextStyle get error {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: ColorsApp.red700, fontSize: 14.0));
  }


  static TextStyle get suggestion {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: ColorsApp.white70, fontSize: 14.0));
  }
}
