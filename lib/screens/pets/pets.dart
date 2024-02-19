// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/constants/routes.dart';
import 'package:pawcontrol/screens/pets/editPetProfile.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/secondary_buttons/roundButtons.dart';
import 'package:pawcontrol/firebase/firebase_firestore/getPetInfo.dart';

class Pets extends StatefulWidget {
  const Pets({Key? key}) : super(key: key);

  @override
  _PetsState createState() => _PetsState();
}

class _PetsState extends State<Pets> {
  List<Map<String, dynamic>> userPets = [];

  @override
  void initState() {
    super.initState();
    _loadUserPets(); // Cargar las mascotas al inicializar el widget
  }

  // Método para cargar las mascotas del usuario
  void _loadUserPets() async {
    List<Map<String, dynamic>> pets = await GetPetInfo.getUserPetsInfo();
    setState(() {
      userPets = pets;
    });
  }

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
                  title: 'Mascotas',
                  showImage: true,
                  showBackButton: true,
                  showLogoutButton: false,
                ),
                SizedBox(height: 20),
                if (userPets.isNotEmpty) ...[
                  CircleAvatar(
                    backgroundImage: NetworkImage(userPets.first['imageUrl']),
                    radius: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    userPets.first['name'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                ],
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          RoundButton(
                            onPressed: () {
                              // Lógica para el botón de registro médico
                            },
                            icon: Icons.local_hospital_outlined,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Registro médico',
                            style: TextsFont.tituloNames,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          RoundButton(
                            onPressed: () {
                              // Lógica para el botón de vacunas
                            },
                            icon: Icons.vaccines_outlined,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Vacunas',
                            style: TextsFont.tituloNames,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          RoundButton(
                            onPressed: () {
                              // Lógica para el botón de medicación
                            },
                            icon: Icons.medication_outlined,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Medicación',
                            style: TextsFont.tituloNames,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          RoundButton(
                            onPressed: () {
                              Routes.instance.pushAndRemoveUntil(
                              widget: EditPetProfile(),
                              context: context,
                            );
                            },
                            icon: Icons.mode_edit_outlined,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Editar perfil',
                            style: TextsFont.tituloNames,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          RoundButton(
                            onPressed: () {
                              // Lógica para el botón de ¿Se perdió tu mascota?
                            },
                            icon: Icons.location_pin,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            '¿Se perdió tu mascota?',
                            style: TextsFont.tituloNames,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
