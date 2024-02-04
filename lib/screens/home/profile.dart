// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/asset_images.dart';
import 'package:pawcontrol/constants/base.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/constants/routes.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/screens/home/home.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';
import 'package:pawcontrol/widgets/socialMediaBtn.dart';

class Profile extends StatelessWidget {
  final int index;

  const Profile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: ColorsApp.white70,
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Image.asset(
                        AssetsImages.instance.logo,
                        width: 60,
                        height: 60,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "PAW CONTROL",
                        style: TextsFont.tituloHeader,
                      ),
                    ],
                  ),
                ),
                // Agrega el contenido específico de la página Profile a continuación
                // Por ejemplo, información del perfil, botones de configuración, etc.
                SizedBox(height: 20),
                Text(
                  "Información del perfil",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // ... Agrega más widgets según sea necesario
              ],
            ),
          ),
        ),
      ),
    );
  }
}
