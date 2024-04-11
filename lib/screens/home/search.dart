// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/constants/theme.dart';
import 'package:pawcontrol/screens/pets/petFoundForm.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/secondary_buttons/roundButtons.dart';


class Search extends StatefulWidget {
  final int index;

  const Search({Key? key, required this.index}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        body: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    Visibility(
                      visible: !isSearching,
                      child: Container(
                        color: ColorsApp.white70, // Asume que tienes un color predefinido
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (!isSearching) Expanded(
                              child: Header(
                                title: 'Mascotas Perdidas',
                                showImage: true,
                                showBackButton: false,
                                showLogoutButton: false,
                              ),
                            ),
                            if (!isSearching) IconButton(
                              onPressed: () {
                                setState(() {
                                  isSearching = true;
                                });
                              },
                              icon: Icon(Icons.search),
                              color: Colors.black,
                            ),
                            if (!isSearching) IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.filter_list),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isSearching) 
                      Container(
                      height: 50, // Altura deseada para el TextField
                      color: ColorsApp.white70, 
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isSearching = false;
                              });
                            },
                            icon: Icon(Icons.arrow_back),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorsApp.grey300, // Color del interior del TextField
                                borderRadius: BorderRadius.circular(25.0), // Radio del borde más redondeado
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 2), // Cambios en la posición de la sombra
                                  ),
                                ],
                              ),
                              child: TextField(
                                autofocus: true,
                                decoration: InputDecoration(
                                  hintText: 'Buscar...',
                                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Padding interno del TextField
                                  border: InputBorder.none, // Elimina el borde por completo
                                ),
                              ),
                            ),
                          ),
                        ]
                      )
                  ),

              SizedBox(height: 20),
                    

                      
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40.0, // Ancho deseado para el botón
                      child: RoundButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PetFoundForm()),
                          );
                        },
                        icon: Icons.add,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Agregar publicación',
                      style: TextsFont.tituloNames,
                    ),
                  ],
                ),
              ),
              
              ],
              ),
              ),
            ),
          ),
        ),
      );
  
  }
}
