
// ignore_for_file: prefer_const_constructors, sort_child_properties_last

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

class PetClinicHistory extends StatefulWidget {
  final String petId;

  const PetClinicHistory({Key? key, required this.petId}) : super(key: key);

  @override
  _PetClinicHistoryState createState() => _PetClinicHistoryState();
}

class _PetClinicHistoryState extends State<PetClinicHistory> {

  
  TextEditingController vaccineNameController = TextEditingController();
  TextEditingController vaccineDateController = TextEditingController();


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
                            'Historial Médico',
                            style: TextsFont.tituloNames,
                          ),
                    SizedBox(height: 20),

                    Container(
                      width: 375.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: ColorsApp.white70,
                      ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                              text: 'Motivo de consulta: Control Anual',
                              style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 18,
                              color: ColorsApp.black,
                              height: 1,
                              )
                            ),
                            WidgetSpan(
                              child: SizedBox(height: 20, width: 60,),
                              ),
                            TextSpan(
                              text: 'Fecha: 10 de Enero 2024',
                              style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 18,
                              color: ColorsApp.black,
                              height: 1,
                              )
                            ),
                            WidgetSpan(
                              child: SizedBox(height: 20, width: 120,),
                              ),
                            TextSpan(
                              text: 'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                              style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 18,
                              color: ColorsApp.black,
                              height: 1,
                              )
                            )
                            ]
                          ),
                          
                          ),
                        ),

                    SizedBox(height: 20),

                    Container(
                      width: 375.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: ColorsApp.white70,
                      ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                              text: 'Tipo Vacuna: Polivalente',
                              style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 18,
                              color: ColorsApp.black,
                              height: 1,
                              )
                            ),
                            WidgetSpan(
                              child: SizedBox(height: 20, width: 120,),
                              ),
                            TextSpan(
                              text: 'Fecha: 28 de Diciembre 2023',
                              style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 18,
                              color: ColorsApp.black,
                              height: 1,
                              )
                            ),
                            WidgetSpan(
                              child: SizedBox(height: 20, width: 120,),
                              ),
                            TextSpan(
                              text: 'Nombre Vacuna: Coronavirus',
                              style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 18,
                              color: ColorsApp.black,
                              height: 1,
                              )
                            )
                            ]
                          ),
                          
                          ),
                        ),

                    SizedBox(height: 20),

                    Container(
                      width: 375.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: ColorsApp.white70,
                      ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                              text: 'Tipo Vacuna: Antirrabica',
                              style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 18,
                              color: ColorsApp.black,
                              height: 1,
                              )
                            ),
                            WidgetSpan(
                              child: SizedBox(height: 20, width: 120,),
                              ),
                            TextSpan(
                              text: 'Fecha: 30 de Octubre 2023',
                              style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 18,
                              color: ColorsApp.black,
                              height: 1,
                              )
                            ),
                            WidgetSpan(
                              child: SizedBox(height: 20, width: 120,),
                              ),
                            TextSpan(
                              text: 'Nombre Vacuna: Rabipur',
                              style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 18,
                              color: ColorsApp.black,
                              height: 1,
                              )
                            )
                            ]
                          ),
                          
                          ),
                        ),

                    SizedBox(height: 20),

                    Container(
                      width: 375.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: ColorsApp.white70,
                      ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                              text: 'Motivo de consulta: Dolor en pata',
                              style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 18,
                              color: ColorsApp.black,
                              height: 1,
                              )
                            ),
                            WidgetSpan(
                              child: SizedBox(height: 20, width: 80,),
                              ),
                            TextSpan(
                              text: 'Fecha: 20 de Agosto 2023',
                              style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 18,
                              color: ColorsApp.black,
                              height: 1,
                              )
                            ),
                            WidgetSpan(
                              child: SizedBox(height: 20, width: 120,),
                              ),
                            TextSpan(
                              text: 'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                              style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 18,
                              color: ColorsApp.black,
                              height: 1,
                              )
                            )
                            ]
                          ),
                          
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