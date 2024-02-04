// search.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/asset_images.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';

class Search extends StatelessWidget {
  final int index;

  const Search({Key? key, required this.index}) : super(key: key);

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
                // Agrega el contenido específico de la página de búsqueda a continuación
                // Por ejemplo, barra de búsqueda, resultados, etc.
                SizedBox(height: 20),
                Text(
                  "Resultados de búsqueda",
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
