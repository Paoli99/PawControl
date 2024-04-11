// ignore_for_file: prefer_const_constructors

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
import 'package:pawcontrol/firebase/firebase_firestore/publishLostPet.dart';
import 'package:pawcontrol/screens/home/search.dart';
import 'package:pawcontrol/screens/pets/pets.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/pictures/addPicture.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';
import 'package:path/path.dart' as Path;


class PetFoundForm extends StatefulWidget {
  const PetFoundForm({Key? key}) : super(key: key);

  

  @override
  State<PetFoundForm> createState() => _PetFoundFormState();
}

class _PetFoundFormState extends State<PetFoundForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController petBreedController = TextEditingController();
  TextEditingController petGenderController = TextEditingController();
  TextEditingController petColorController = TextEditingController();
  String imageUrl = "";

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
  }

  void _updateBreedsAndItems() {
    breedList = selectedSpecies == null 
                ? null 
                : (selectedSpecies == 'Perro' ? dogBreeds : catBreeds);
    
    breedDropdownItems = breedList?.map((value) => DropdownMenuItem(
      value: value,
      child: Text(value),
    )).toList() ?? [];
  }

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      showLoaderDialog(context);
      try {
        String fileName = "foundPets/${DateTime.now().millisecondsSinceEpoch}_${Path.basename(pickedFile.path)}";
        Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
        await storageRef.putFile(File(pickedFile.path));
        String downloadUrl = await storageRef.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
        Navigator.pop(context);
      } catch (e) {
        Navigator.pop(context);
        print(e);
      }
    }
  }
  
  void setImageUrl(String path) {
    setState(() {
      imageUrl = path;
    });
  }

    void navigateBack(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Search(index: 1)),
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
                AddPicture(
                  imageUrl: imageUrl,
                  setImageUrl: setImageUrl,
                  onPressed: pickImage
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
                    SizedBox(height: 20),
                    DropDownListView<String>(
                      label: 'Color',
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
                          petColorController.text = value ?? '';
                        });
                      },
                    ),
                    
                    SizedBox(
                      height: 15.0,
                    ),
                    TextInputFields(
                      controller: dateController,
                      hintText: 'Dia que se perdio',
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
                    SizedBox(height: 150,
                    child: TextInputFields(
                      controller: descriptionController,
                      hintText: 'Descripcion detallada de la mascota',
                      prefixIcon: Icon(
                        Icons.description_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFields(
                      controller: phoneController,
                      hintText: 'Ingrese su numero de teléfono',
                      prefixIcon: Icon(
                        Icons.phone_iphone_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                      keyboardType: TextInputType.numberWithOptions(decimal: false),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                  ],
                ),
                PrimaryButton(
                      title: 'Publicar',
                      onPressed: () {
                        publishLostPet(
                          context: context,
                          name: nameController.text,
                          date: dateController.text,
                          location: locationController.text,
                          description: descriptionController.text,
                          phone: int.tryParse(phoneController.text) ?? 0,
                          imageUrl: imageUrl,
                        );
                      },
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
