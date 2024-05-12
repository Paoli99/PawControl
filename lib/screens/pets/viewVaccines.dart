// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/dropListView.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/constants/routes.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/firebase/firebase_firestore/getPetInfo.dart';
import 'package:pawcontrol/screens/home/home.dart';
import 'package:pawcontrol/screens/home/profile.dart';
import 'package:pawcontrol/screens/home/search.dart';
import 'package:pawcontrol/screens/pets/addVaccines.dart';
import 'package:pawcontrol/screens/pets/pets.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/pictures/addPicture.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';
import 'package:pawcontrol/widgets/secondary_buttons/roundButtons.dart';

class ViewVaccines extends StatefulWidget {
  final String petId;

  const ViewVaccines({Key? key, required this.petId}) : super(key: key);

  @override
  _ViewVaccinesState createState() => _ViewVaccinesState();
}

class _ViewVaccinesState extends State<ViewVaccines> {

  
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
                     Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          RoundButton(
                            onPressed: () {
                              Routes.instance.pushAndRemoveUntil(
                              widget: AddVaccines(petId: widget.petId),
                              context: context,
                            );
                            },
                            icon: Icons.add,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Registrar Vacuna',
                            style: TextsFont.tituloNames,
                          ),
                        ],
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
