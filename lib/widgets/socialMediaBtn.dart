import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pawcontrol/constants/buttons.dart';
import 'package:pawcontrol/constants/colors.dart';
//import 'package:flutter_font_awesome/flutter_font_awesome.dart';

class SocialMediaBtn extends StatelessWidget {
  final String textoRedes;
  final TipoRedes tipoRedes;
  final void Function()? onPressed;

  SocialMediaBtn({required this.textoRedes, required this.tipoRedes, this.onPressed});

  IconData get icon {
    switch (tipoRedes) {
      case TipoRedes.Facebook:
        return FontAwesomeIcons.facebook;
      case TipoRedes.Google:
        return FontAwesomeIcons.google;
      default:
        return FontAwesomeIcons.google;
    }
  }

  Color get iconoColor {
    switch (tipoRedes) {
      case TipoRedes.Facebook:
        return Colors.white;
      case TipoRedes.Google:
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  Color get colorBoton {
    switch (tipoRedes) {
      case TipoRedes.Facebook:
        return ColorsApp.azulFacebook;
      case TipoRedes.Google:
        return ColorsApp.rojoGoogle;
      default:
        return ColorsApp.rojoGoogle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: ButtonStyles.buttonHeightSM,
        width: ButtonStyles.buttonHeightSM,
        decoration: BoxDecoration(
          color: colorBoton,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          color: iconoColor,
          size: 24.0, // Ajusta el tamaño del icono según tus necesidades
        ),
      ),
    );
  }
}

enum TipoRedes { Facebook, Google }