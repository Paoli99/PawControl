// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/screens/pets/petFoundForm.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/secondary_buttons/roundButtons.dart';


class Pet {
  final String name;
  final String species;
  final String breed;
  final String gender;
  final String date;
  final String location;
  final String description;
  final int phone;
  //final String imageUrl;

  Pet({
    this.name = '',
    required this.species,
    required this.breed,
    required this.gender,
    required this.date,
    required this.location,
    required this.description,
    required this.phone,
    //required this.imageUrl,
  });

  factory Pet.fromMap(Map<String, dynamic> data, {bool isLostPet = true}) {
    return Pet(
      name: isLostPet ? data['name'] ?? '' : '',
      species: data['species'] ?? '',
      breed: data['breed'] ?? '',
      gender: data['gender'] ?? '',
      date: data['date'] ?? '',
      location: data['location'] ?? '',
      description: data['description'] ?? '',
      phone: data['phone'] ?? 0,
      //imageUrl: data['imageURL'] ?? '',
    );
  }
}

class PetCard extends StatelessWidget {
  final Pet pet;
  final VoidCallback onTap;

  PetCard({required this.pet, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            //Image.network(pet.imageUrl, height: 150, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (pet.name.isNotEmpty) Text("Nombre: ${pet.name}", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Especie: ${pet.species}"),
                  Text("Raza: ${pet.breed}"),
                  Text("Género: ${pet.gender}"),
                  Text("Fecha: ${pet.date}"),
                  Text("Ubicación: ${pet.location}"),
                  Text("Descripción: ${pet.description}"),
                  Text("Teléfono: ${pet.phone}"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Search extends StatefulWidget {
  final int index;

  const Search({Key? key, required this.index}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isSearching = false;


  Future<List<Pet>> fetchPets(String collection) async {
    bool isLostPet = collection == 'lostPets';
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(collection).get();
    return querySnapshot.docs.map((doc) => Pet.fromMap(doc.data() as Map<String, dynamic>, isLostPet: isLostPet)).toList();
  }

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
                        color: ColorsApp.white70, 
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
                                color: ColorsApp.grey300, 
                                borderRadius: BorderRadius.circular(25.0), 
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 2), 
                                  ),
                                ],
                              ),
                              child: TextField(
                                autofocus: true,
                                decoration: InputDecoration(
                                  hintText: 'Buscar...',
                                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), 
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
                      width: 40.0, 
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
              
              FutureBuilder<List<Pet>>(
                    future: fetchPets('lostPets'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) => PetCard(
                            pet: snapshot.data![index],
                            onTap: () {
                              //
                            },
                          ),
                        );
                      }
                    },
                  ),

              FutureBuilder<List<Pet>>(
                    future: fetchPets('foundPets'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) => PetCard(
                            pet: snapshot.data![index],
                            onTap: () {
                              // 
                            },
                          ),
                        );
                      }
                    },
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
