// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/screens/pets/petFoundForm.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/secondary_buttons/roundButtons.dart';

void main() => runApp(const Search(index: 0));

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
    return MaterialApp(
      home: Scaffold(
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
                        width: 430,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Header(
                                title: 'Mascotas Perdidas',
                                showImage: true,
                                showBackButton: false,
                                showLogoutButton: false,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isSearching = !isSearching;
                                });
                              },
                              icon: Icon(
                                Icons.search,
                                color: isSearching ? Colors.blue : Colors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Agrega aquí la lógica para el filtro
                              },
                              icon: Icon(Icons.filter_list),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    if (isSearching)
                      Row(
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
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Buscar...',
                              ),
                              // Aquí puedes manejar la lógica de búsqueda
                            ),
                          ),
                        ],
                      ),

                      
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
      ),
    );
  }
}
