// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/textFields.dart';
import 'package:pawcontrol/firebase/firebase_firestore/updatePetInfo.dart';
import 'package:pawcontrol/screens/pets/pets.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/pictures/addPicture.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';
import 'package:pawcontrol/firebase/firebase_firestore/getPetInfo.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/constants/dropListView.dart';

class EditPetProfile extends StatefulWidget {
  final String petId; 
  const EditPetProfile({Key? key, required this.petId}) : super(key: key);

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

  late UpdatePetInfo _updatePetInfo;
  List<Map<String, dynamic>> userPets = [];

  @override
  void initState() {
    checkUserAuthentication();
    super.initState();
    _updatePetInfo = UpdatePetInfo(userId: FirebaseAuth.instance.currentUser!.uid, context: context);
    loadPetInfo();
  }

  void navigateBack(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Pets(petId: widget.petId)),
  ); 
}

  Future<void> loadPetInfo() async {
    try {
    Map<String, dynamic> petInfo = await GetPetsInfo.getPetInfo(widget.petId);
    setState(() {
      nameController.text = petInfo['name'] ?? '';
      speciesController.text = petInfo['species'];
      breedController.text = petInfo['breed'] ?? '';
      colorController.text = petInfo['color'] ?? '';
      birthDateController.text = petInfo['birthDate'] ?? '';
      weightController.text = petInfo['weight'] ?? '';
      sexController.text = petInfo['sex'] ?? '';
      userPets.add(petInfo); 
    });
  } catch (e) {
    print('Error al cargar la información de la mascota: $e');
  }
  }

  String imageUrl = "";

  void setImageUrl(String url) {
        setState(() {
          imageUrl = url;
        });
      }

  void updatePet() {
    _updatePetInfo.updatePetInfo(
      species: speciesController.text,
      petId: widget.petId,
      name: nameController.text,
      breed: breedController.text,
      color: colorController.text,
      sex: sexController.text,
      weight: weightController.text,
      birthDate: birthDateController.text,
      context: context,
    );
  }

  void updatePetProfileImage() async {
    UpdatePetInfo updatePetInfoInstance = UpdatePetInfo(userId: widget.petId, context: context);
    String? uploadedImageUrl = await updatePetInfoInstance.pickAndUploadImage(setImageUrl);
    if (uploadedImageUrl != null) {
      // La imagen se cargó correctamente, puedes hacer cualquier otra acción necesaria aquí
    } else {
      // La carga de la imagen falló, manejar según sea necesario
    }
  }

  void checkUserAuthentication() {
  // Obtener el usuario actualmente autenticado
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // El usuario está autenticado
    print('El usuario ${user.uid} está autenticado.');
  } else {
    // El usuario no está autenticado
    print('El usuario no está autenticado.');
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
                title: 'PAW CONTROL',
                showImage: true,
                showBackButton: true,
                navigateTo: navigateBack, // Define la ruta específica aquí
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  for (var petInfo in userPets)
                    Column(
                      children: [
                        AddPicture(imageUrl: petInfo['imageUrl'] ?? '', 
                        setImageUrl: setImageUrl,
                        onPressed: updatePetProfileImage,
                        ),
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
                        value: speciesController.text ?? '',
                        items: ['Perro', 'Gato']
                            .map((value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            speciesController.text = value ?? '';
                          });
                        },
                      ),
                        SizedBox(height: 20),
                        DropDownListView<String>(
                          label: 'Raza',
                          value: breedController.text ?? '',
                          items: breedDropdownItems(speciesController.text),
                          onChanged: (value) {
                            setState(() {
                              breedController.text = value ?? '';
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        DropDownListView<String>(
                          label: 'Sexo',
                          value: sexController.text ?? '',
                          items: ['Macho', 'Hembra']
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              sexController.text = value ?? '';
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        DropDownListView<String>(
                          label: 'Color',
                          value: colorController.text ?? '',
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
                            setState(() {
                              colorController.text = value ?? '';
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        TextInputFields(
                          controller: birthDateController..text = petInfo['birthDate'] ?? '',
                          hintText: 'Fecha de nacimiento',
                          prefixIcon: Icon(
                            Icons.cake_outlined,
                            color: Colors.grey,
                          ),
                          backgroundColor: ColorsApp.white70,
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
                          onPressed: updatePet,
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