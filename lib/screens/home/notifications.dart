// search.dart
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pawcontrol/widgets/header/header.dart';

class Notifications extends StatelessWidget {
  final int index;

  const Notifications({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Header(
                  title: 'Notificaciones',
                  showImage: true,
                  showBackButton: false,
                  showLogoutButton: false,
                  
                ),
                // Agrega el contenido específico de la página de búsqueda a continuación
                // Por ejemplo, barra de búsqueda, resultados, etc.
                SizedBox(height: 20),
                Text(
                  "Sin notificaciones",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
