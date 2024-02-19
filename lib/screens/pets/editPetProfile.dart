// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/textFields.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/pictures/addPicture.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawcontrol/firebase/firebase_firestore/getPetInfo.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/constants/dropListView.dart';
import 'package:pawcontrol/constants/datePicker.dart';

class EditPetProfile extends StatefulWidget {
  const EditPetProfile({Key? key}) : super(key: key);

  @override
  State<EditPetProfile> createState() => _EditPetProfileState();
}

class _EditPetProfileState extends State<EditPetProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController breedController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController speciesController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  List<Map<String, dynamic>> userPets = [];

  @override
  void initState() {
    super.initState();
    getUserPets();
  }

  Future<void> getUserPets() async {
    try {
      List<Map<String, dynamic>> petsInfo = await GetPetInfo.getUserPetsInfo();
      setState(() {
        userPets = petsInfo;
      });
    } catch (e) {
      print('Error al obtener la información de las mascotas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Header(
                title: 'Editar Perfil de Mascotas',
                showImage: false,
                showBackButton: true,
                showLogoutButton: false,
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  for (var petInfo in userPets)
                    Column(
                      children: [
                        AddPicture(imageUrl: petInfo['imageUrl'] ?? '', onPressed: () {}, setImageUrl: (String) {}),
                        SizedBox(height: 20),
                        TextInputFields(
                          controller: nameController..text = petInfo['name'] ?? '',
                          hintText: 'Nombre',
                          prefixIcon: Icon(
                            Icons.pets_outlined,
                            color: Colors.grey,
                          ),
                          backgroundColor: ColorsApp.white70,
                        ),
                        SizedBox(height: 20),
                        DropDownListView<String>(
                          label: 'Especie',
                          value: petInfo['species'] ?? '',
                          items: ['Perro', 'Gato']
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            // Implementa la lógica para cambiar la especie
                          },
                        ),
                        SizedBox(height: 20),
                        DropDownListView<String>(
                          label: 'Raza',
                          value: petInfo['breed'] ?? '',
                          items: breedDropdownItems(petInfo['species']),
                          onChanged: (value) {
                            // Implementa la lógica para cambiar la raza
                          },
                        ),
                        SizedBox(height: 20),
                        DropDownListView<String>(
                          label: 'Sexo',
                          value: petInfo['sex'] ?? '',
                          items: ['Macho', 'Hembra']
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            // Implementa la lógica para cambiar el sexo
                          },
                        ),
                        SizedBox(height: 20),
                        DropDownListView<String>(
                          label: 'Color',
                          value: petInfo['color'] ?? '',
                          items: [
                            'Blanco',
                            'Negro',
                            'Marrón',
                            'Gris',
                            'Beige',
                            'Naranja',
                            'Atigrado',
                            'Tricolor',
                            'Gris Azulado',
                            'Blanco y negro',
                            'Otro',
                          ]
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            // Implementa la lógica para cambiar el color
                          },
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            // Implementa la lógica para seleccionar la fecha de nacimiento
                          },
                          child: DatePickerField(
                            selectedDate: DateTime.parse(petInfo['birthDate'] ?? ''),
                            onSelectDate: (DateTime? date) {
                              // Implementa la lógica para seleccionar la fecha de nacimiento
                            },
                            onTap: (context) {
                              // Implementa la lógica para seleccionar la fecha de nacimiento
                            },
                            placeholderText: 'Fecha de nacimiento',
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFields(
                          controller: weightController..text = petInfo['weight'] ?? '',
                          hintText: 'Peso',
                          prefixIcon: Icon(
                            Icons.monitor_weight_outlined,
                            color: Colors.grey,
                          ),
                          backgroundColor: ColorsApp.white70,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                        ),
                        SizedBox(height: 20),
                        PrimaryButton(
                          title: 'Actualizar Mascota',
                          onPressed: () {
                            // Implementa la lógica para actualizar la información de la mascota
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> breedDropdownItems(String? species) {
    List<String>? breedList = species == null ? null : (species == 'Perro' ? dogBreeds : catBreeds);

    return breedList?.map((value) => DropdownMenuItem(
          value: value,
          child: Text(value),
        )).toList() ?? [];
  }

  static const List<String> dogBreeds = [
    'Mestizo',
    'Chihuahua',
    'Cooker',
    'Bulldog',
    'Labrador Retriever',
    'Golden Retriever',
    'Pastor Alemán',
    'Boxer',
    'Shih Tzu',
    'Pomerania',
    'Yorkshire Terrier',
    'Otra',
  ];

  static const List<String> catBreeds = [
    'Mestizo',
    'Siamés',
    'Persa',
    'Maine Coon',
    'Ragdoll',
    'Bengal',
    'British Shorthair',
    'Scottish Fold',
    'Sphynx',
    'Otro',
  ];
}
