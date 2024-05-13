// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final List<String> imageUrls;
  final bool isFoundPet;

  Pet({
    this.name = '',
    required this.species,
    required this.breed,
    required this.gender,
    required this.date,
    required this.location,
    required this.description,
    required this.phone,
    required this.imageUrls,
    this.isFoundPet = true,
  });

  factory Pet.fromMap(Map<String, dynamic> data, bool isFoundPet) {
    List<String> imageUrls = [];
    if (data['imageUrls'] != null) {
      imageUrls = List<String>.from(data['imageUrls']);
    } else {
      imageUrls = ['https://via.placeholder.com/150'];
    }
    //print("Loaded image URL: $imageUrl"); 
    return Pet(
      name: data['name'] ?? '',
      species: data['species'] ?? '',
      breed: data['breed'] ?? '',
      gender: data['gender'] ?? '',
      date: data['date'] ?? '',
      location: data['location'] ?? '',
      description: data['description'] ?? '',
      phone: data['phone'] as int? ?? 0,
      imageUrls: imageUrls, 
      isFoundPet: isFoundPet,
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
              child: Image.network(pet.imageUrls.isNotEmpty ? pet.imageUrls[0] : 'https://via.placeholder.com/150', width: 120, height: 180, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
                return Container(width: 100, height: 100, color: Colors.grey[300], child: Icon(Icons.broken_image));
              }),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pet.isFoundPet ? "Mascota Encontrada" : "Mascota Extraviada", style: TextStyle(color: ColorsApp.rojoGoogle, fontWeight: FontWeight.bold, fontSize: 16)),
                    if (!pet.isFoundPet) buildDetailRow("Nombre:", pet.name),
                    buildDetailRow("Especie:", pet.species),
                    buildDetailRow("Raza:", pet.breed),
                    buildDetailRow("Género:", pet.gender),
                    buildDetailRow("Fecha:", pet.date),
                    buildDetailRow("Ubicación:", pet.location),
                    buildDetailRow("Descripción:", pet.description),
                    buildDetailRow("Teléfono:", pet.phone.toString()),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildDetailRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black), 
        children: [
          TextSpan(text: "$label ", style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: value, style: TextStyle(fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }


class Search extends StatefulWidget {
  final int index;

  const Search({Key? key, required this.index}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isSearching = false;
  bool isLoading = true;

  Future<List<Pet>> fetchPets(String collection) async {
    print("Fetching pets from: $collection");  
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection(collection)
              .orderBy('createdAt', descending: true)
              .get();
    bool isFoundPet = collection.contains('foundPetsForms');  
    return querySnapshot.docs.map((doc) {
      print("Pet ID from $collection: ${doc.id}");  
      return Pet.fromMap(doc.data() as Map<String, dynamic>, isFoundPet);
    }).toList();
  }

  Future<List<Pet>> getInterleavedPets() async {
    List<Pet> lostPets = await fetchPets('lostPetsForms');
    List<Pet> foundPets = await fetchPets('foundPetsForms');
    List<Pet> interleaved = [];
    int maxLength = max(lostPets.length, foundPets.length);
    for (int i = 0; i < maxLength; i++) {
      if (i < lostPets.length) interleaved.add(lostPets[i]);
      if (i < foundPets.length) interleaved.add(foundPets[i]);
    }
    isLoading = false;
    return interleaved;
  }

  Future<void> refreshPets() async {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshPets,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
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
                  if (isSearching) Container(
                    height: 50,
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
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
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
                    future: getInterleavedPets(),
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
