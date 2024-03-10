// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/dropListView.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/firebase/firebase_firestore/getPetInfo.dart';
import 'package:pawcontrol/screens/home/home.dart';
import 'package:pawcontrol/screens/home/profile.dart';
import 'package:pawcontrol/screens/home/search.dart';
import 'package:pawcontrol/screens/pets/pets.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/pictures/addPicture.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';

class AddVaccines extends StatefulWidget {
  final String petId;

  const AddVaccines({Key? key, required this.petId}) : super(key: key);

  @override
  _AddVaccinesState createState() => _AddVaccinesState();
}

class _AddVaccinesState extends State<AddVaccines> {

  
  TextEditingController vaccineNameController = TextEditingController();
  TextEditingController vaccineDateController = TextEditingController();
  TextEditingController nextVaccineDateController = TextEditingController();


  @override
  void navigateBack(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Pets(petId: widget.petId,)),
  );
  }
  Widget build(BuildContext context) {
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
                    Text(
                            'Agregar Vacunas',
                            style: TextsFont.tituloNames,
                          ),
                    SizedBox(height: 20),
                    TextInputFields(
                      controller: vaccineNameController,
                      hintText: 'Nombre de la mascota',
                      prefixIcon: Icon(
                        Icons.pets_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(height: 20),
                    TextInputFields(
                      controller: vaccineDateController,
                      hintText: 'Nombre de vacuna',
                      prefixIcon: Icon(
                        Icons.pets_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(height: 20),
                    TextInputFields(
                      controller: vaccineDateController,
                      hintText: 'Fecha',
                      prefixIcon: Icon(
                        Icons.pets_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(height: 20),
                    TextInputFields(
                      controller: nextVaccineDateController,
                      hintText: 'Fecha de la siguiente vacuna',
                      prefixIcon: Icon(
                        Icons.pets_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: PrimaryButton(
                        title: 'Registrar vacuna',
                        onPressed: ()  {
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
