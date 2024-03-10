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

class AddVetVisit extends StatefulWidget {
  final String petId;

  const AddVetVisit({Key? key, required this.petId}) : super(key: key);

  @override
  _AddVetVisitState createState() => _AddVetVisitState();
}

class _AddVetVisitState extends State<AddVetVisit> {

  
  TextEditingController petNameController = TextEditingController();
  TextEditingController visitDateController = TextEditingController();
  TextEditingController visitMotiveController = TextEditingController();


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
                            'Registrar Consulta Médica',
                            style: TextsFont.tituloNames,
                          ),
                    SizedBox(height: 20),
                    TextInputFields(
                      controller: petNameController,
                      hintText: 'Nombre de la mascota',
                      prefixIcon: Icon(
                        Icons.pets_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(height: 20),
                    TextInputFields(
                      controller: visitDateController,
                      hintText: 'Fecha',
                      prefixIcon: Icon(
                        Icons.pets_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 350,
                    child: TextInputFields(
                      controller: visitMotiveController,
                      hintText: 'Motivo de la consulta',
                      prefixIcon: Icon(
                        Icons.pets_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    ),
                    SizedBox(height: 20),
                    
                    Center(
                      child: PrimaryButton(
                        title: 'Registrar consulta',
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
