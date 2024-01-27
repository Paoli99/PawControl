import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';

ThemeData themeData=ThemeData(
  scaffoldBackgroundColor: ColorsApp.grey300,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorsApp.grey100,
      textStyle: TextsFont.buttonTextLight,
      disabledBackgroundColor: ColorsApp.grey100
    ),
    
    )
);