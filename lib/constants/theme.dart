import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';

ThemeData themeData=ThemeData(
  scaffoldBackgroundColor: ColorsApp.grey300,
  inputDecorationTheme:  InputDecorationTheme(
    border: outlineInputBorder,
    errorBorder: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    disabledBorder: outlineInputBorder,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorsApp.grey100,
      textStyle: TextsFont.buttonTextLight,
      disabledBackgroundColor: ColorsApp.grey100
    ),
    
    )
);

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color:  Colors.black87,
  ),
  borderRadius: BorderRadius.circular(10.0),
);