// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:math';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/constants.dart';
import 'package:pawcontrol/constants/dropListView.dart';
import 'package:pawcontrol/constants/textFields.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/firebase/firebase_firestore/publishFoundPet.dart';
import 'package:pawcontrol/screens/home/home.dart';
import 'package:pawcontrol/screens/home/search.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';
import 'package:path/path.dart' as Path;

class PetFoundForm extends StatefulWidget {
  const PetFoundForm({Key? key}) : super(key: key);

  @override
  State<PetFoundForm> createState() => _PetFoundFormState();
}

class _PetFoundFormState extends State<PetFoundForm> {
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController petBreedController = TextEditingController();
  TextEditingController petGenderController = TextEditingController();
  TextEditingController petColorController = TextEditingController();
  List<String> imageUrls = ['', '', ''];
  bool isPickerActive = false;
  String userId = '';
  String publicationId = '';  

  List<String>? breedList;
  List<DropdownMenuItem<String>> breedDropdownItems = [];

  String? selectedSpecies;

  List<String> dogBreeds = [
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
    'Pequines Albino',
    'Chapi',
    'Pincher',
    'Schnauzer',
    'Otra',
  ];

  List<String> catBreeds = [
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

  @override
  void initState() {
    super.initState();
    _updateBreedsAndItems();
    userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  void _updateBreedsAndItems() {
    breedList = selectedSpecies == null
        ? null
        : (selectedSpecies == 'Perro' ? dogBreeds : catBreeds);

    breedDropdownItems = breedList
            ?.map((value) => DropdownMenuItem(
                  value: value,
                  child: Text(value),
                ))
            .toList() ??
        [];
  }

  String generateRandomString(int length) {
    const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ));
  }

  Future<void> pickImage(int index, String publicationId) async {
    if (isPickerActive) return;
    setState(() => isPickerActive = true);

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 75,
    );

    if (image != null) {
      String fileName = '$publicationId/${publicationId}_$index.jpg';
      Reference ref = FirebaseStorage.instance.ref().child("foundPetFormPhotos/$fileName");
      await ref.putFile(File(image.path));
      String downloadURL = await ref.getDownloadURL();
      setState(() {
        imageUrls[index] = downloadURL;
      });
    }

    setState(() => isPickerActive = false);
  }

  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  Widget imagePlaceholder(int index, String title, String defaultImagePath) {
    bool isBackImage = index == 2;
    double imageSize = isBackImage ? 100 : 100;
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        InkWell(
          onTap: () async {
            if (publicationId.isEmpty) {
              String randomString = generateRandomString(4);
              setState(() {
                publicationId = '${userId}_$randomString';  
              });
            }
            await pickImage(index, publicationId);
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
              child: imageUrls[index].isEmpty
                  ? Image.asset(defaultImagePath,
                      fit: BoxFit.contain, width: imageSize, height: imageSize)
                  : Image.network(imageUrls[index], fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
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
                  title: 'Formulario de mascota',
                  showImage: true,
                  showBackButton: true,
                  showLogoutButton: false,
                  navigateTo: navigateBack,
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    imagePlaceholder(0, 'Frente', 'assets/icons/FrontDog.png'),
                    imagePlaceholder(1, 'Costado', 'assets/icons/SideDog.png'),
                    imagePlaceholder(2, 'Espalda', 'assets/icons/BackDog.png'),
                  ],
                ),
                SizedBox(height: 20.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DropDownListView<String>(
                      label: 'Especie',
                      value: selectedSpecies,
                      items: ['Perro', 'Gato']
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSpecies = value!;
                          _updateBreedsAndItems();
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    DropDownListView<String>(
                      label: 'Raza',
                      items: breedDropdownItems,
                      onChanged: (value) {
                        setState(() {
                          petBreedController.text = value ?? '';
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    DropDownListView<String>(
                      label: 'Sexo',
                      items: ['Macho', 'Hembra']
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          petGenderController.text = value ?? '';
                        });
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextInputFields(
                      controller: dateController,
                      hintText: 'Día que se encontró',
                      prefixIcon: Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextInputFields(
                      controller: locationController,
                      hintText: 'Ubicación',
                      prefixIcon: Icon(
                        Icons.pin_drop_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      height: 150,
                      decoration: BoxDecoration(
                        color: ColorsApp.grey300,
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: ColorsApp.grey300,
                            blurRadius: 25,
                          ),
                        ],
                        border: Border.all(color: Colors.transparent, width: 1.0),
                      ),
                      child: TextField(
                        controller: descriptionController,
                        maxLines: null,
                        minLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Descripción detallada de la mascota',
                          prefixIcon: Icon(Icons.description_outlined,
                              color: Colors.grey, size: 24),
                          fillColor: ColorsApp.white70,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 60.0, horizontal: 10.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFields(
                      controller: phoneController,
                      hintText: 'Ingrese su número de teléfono',
                      prefixIcon: Icon(
                        Icons.phone_iphone_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: false),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
                PrimaryButton(
                  title: 'Publicar',
                  onPressed: () async {
                    if (publicationId.isEmpty) {
                      String randomString = generateRandomString(4);
                      setState(() {
                        publicationId = '${userId}_$randomString';  
                      });
                    }

                    await publishFoundPet(
                      context: context,
                      userId: userId,
                      species: selectedSpecies ?? '',
                      breed: petBreedController.text,
                      date: dateController.text,
                      gender: petGenderController.text,
                      location: locationController.text,
                      description: descriptionController.text,
                      phone: int.tryParse(phoneController.text) ?? 0,
                      imageUrls: imageUrls,
                      publicationId: publicationId,  
                    );

                     Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    ); 
                    
                    
                  },
                ),
                SizedBox(
                  height: 25.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
