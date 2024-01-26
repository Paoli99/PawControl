import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';

ThemeData themeData=ThemeData(
  scaffoldBackgroundColor: ColorsApp.deepPurple100,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorsApp.deepPurple400,
      textStyle: TextsFont.buttonTextLight,
      disabledBackgroundColor: ColorsApp.grey300
    ),
    
    )
);