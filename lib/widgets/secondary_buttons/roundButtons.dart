// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/buttons.dart';
import 'package:pawcontrol/constants/colors.dart';

class RoundButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;

  const RoundButton({Key? key, this.onPressed, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: ButtonStyles.buttonHeightLogin, // Tamaño del botón circular
        height: ButtonStyles.buttonHeightLogin, // Tamaño del botón circular
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorsApp.redAccent400, // Color de fondo del botón
        ),
        child: Center(
          child: Icon(
            icon, // Icono del botón
            color: ColorsApp.white,
            size: 40, // Tamaño del icono (ajústalo según sea necesario)
          ),
        ),
      ),
    );
  }
}
