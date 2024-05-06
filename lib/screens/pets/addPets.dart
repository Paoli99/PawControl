// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/routes.dart';
import 'package:pawcontrol/constants/textFields.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/screens/home/home.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/pictures/addPicture.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';
import 'package:pawcontrol/constants/dropListView.dart';
import 'package:pawcontrol/firebase/firebase_firestore/addPetsInfo.dart';

class AddPets extends StatefulWidget {
  @override
  _AddPetsState createState() => _AddPetsState();
}

class _AddPetsState extends State<AddPets> {
  String? selectedSpecies;
  TextEditingController petNameController = TextEditingController();
  TextEditingController petBreedController = TextEditingController();
  TextEditingController petGenderController = TextEditingController();
  TextEditingController petColorController = TextEditingController();
  TextEditingController petWeight = TextEditingController();
  TextEditingController petBirthDate = TextEditingController();
  String? imageUrl;

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
    'Pequines Albino'
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
  Widget build(BuildContext context) {
    void _setImageUrl(String url) {
      setState(() {
        imageUrl = url;
      });
    }

    void navigateBack(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Home()),
  );
  }

    List<String>? breedList =
        selectedSpecies == null ? null : (selectedSpecies == 'Perro' ? dogBreeds : catBreeds);

    List<DropdownMenuItem<String>> breedDropdownItems = breedList?.map((value) => DropdownMenuItem(
          value: value,
          child: Text(value),
        )).toList() ?? [];

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Header(title: 'PAW CONTROL', showImage: true, showBackButton: true, navigateTo: navigateBack),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: AddPicture(
                        imageUrl: imageUrl ?? "",
                        setImageUrl: _setImageUrl,
                        onPressed: () async {
                          String? uploadedImageUrl = await AddPetsInfo.pickAndUploadImage((String url) {
                            _setImageUrl(url);
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    TextInputFields(
                      controller: petNameController,
                      hintText: 'Ingrese el nombre de su mascota',
                      prefixIcon: Icon(
                        Icons.pets_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
                    TextFields(
                      controller: petWeight,
                      hintText: 'Ingrese el peso de su mascota',
                      prefixIcon: Icon(
                        Icons.monitor_weight_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),

                    ),
                    SizedBox(height: 20),
                    TextInputFields(
                      controller: petBirthDate,
                      hintText: 'Ingrese el nombre de su mascota',
                      prefixIcon: Icon(
                        Icons.pets_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: PrimaryButton(
                        title: 'Registrar mascota',
                        onPressed: () async {
                          bool success = await AddPetsInfo.registerPet(
                            context: context,
                            petName: petNameController.text,
                            selectedSpecies: selectedSpecies ?? '',
                            selectedBreed: petBreedController.text,
                            selectedSex: petGenderController.text,
                            selectedColor: petColorController.text,
                            imageUrl: imageUrl ?? '',
                            petWeight: petWeight.text,
                            birthDate: petBirthDate.text,
                          );
                          if (success) {
                            Routes.instance.pushAndRemoveUntil(
                              widget: const Home(),
                              context: context,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
