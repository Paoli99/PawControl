// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/constants/routes.dart';
import 'package:pawcontrol/screens/home/home.dart';
import 'package:pawcontrol/screens/pets/addVaccines.dart';
import 'package:pawcontrol/screens/pets/addVetVisit.dart';
import 'package:pawcontrol/screens/pets/editPetProfile.dart';
import 'package:pawcontrol/screens/pets/petClinicHistory.dart';
import 'package:pawcontrol/screens/pets/petLostForm.dart';
import 'package:pawcontrol/screens/pets/viewVaccines.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/secondary_buttons/roundButtons.dart';
import 'package:pawcontrol/firebase/firebase_firestore/getPetInfo.dart';

class Pets extends StatefulWidget {
  final String petId;

  const Pets({Key? key, required this.petId}) : super(key: key);

  @override
  _PetsState createState() => _PetsState();
}

class _PetsState extends State<Pets> {
   Map<String, dynamic> petInfo = {};

  @override
  void initState() {
    super.initState();
    _loadUserPets(); // Cargar las mascotas al inicializar el widget
  }

  // Método para cargar las mascotas del usuario
  void _loadUserPets() async {
    try {
      Map<String, dynamic> pet = await GetPetsInfo.getPetInfo(widget.petId);
      setState(() {
        petInfo = pet;
      });
    } catch (e) {
      print('Error al cargar la información de la mascota: $e');
    }
  }

  void navigateBack(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Home()),
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
                  title: 'Mascotas',
                  showImage: true,
                  showBackButton: true,
                  showLogoutButton: false,
                  navigateTo: navigateBack,
                ),
                SizedBox(height: 20),
                if (petInfo.isNotEmpty) ...[
                  CircleAvatar(
                    backgroundImage: NetworkImage(petInfo['imageUrl']),
                    radius: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    petInfo['name'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                ],
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          RoundButton(
                            onPressed: () {
                              Routes.instance.pushAndRemoveUntil(
                              widget: AddVetVisit(petId: widget.petId,),
                              context: context,
                              ); 
                            },
                            icon: Icons.local_hospital_outlined,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Registrar consulta médica',
                            style: TextsFont.tituloNames,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          RoundButton(
                            onPressed: () {
                              Routes.instance.pushAndRemoveUntil(
                              widget: ViewVaccines(petId: widget.petId,),
                              context: context,
                              ); 
                            },
                            icon: Icons.vaccines_outlined,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Vacunas',
                            style: TextsFont.tituloNames,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          RoundButton(
                            onPressed: () {
                              Routes.instance.pushAndRemoveUntil(
                              widget: PetClinicHistory(petId: widget.petId,),
                              context: context,
                              ); 
                            },
                            icon: Icons.medication_outlined,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Historial médico',
                            style: TextsFont.tituloNames,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          RoundButton(
                            onPressed: () {
                              Routes.instance.pushAndRemoveUntil(
                              widget: EditPetProfile(petId: widget.petId),
                              context: context,
                            );
                            },
                            icon: Icons.mode_edit_outlined,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Editar perfil',
                            style: TextsFont.tituloNames,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          RoundButton(
                            onPressed: () {
                              showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  title: Text("¿Se perdió tu mascota?"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          style: TextStyle(color: ColorsApp.black87),
                                          children: [
                                            TextSpan(
                                              text: '¿Deseas llenar un formulario para que ',
                                            ),
                                            TextSpan(
                                              text: petInfo['name'],
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: ' aparezca en el foro?',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(color: ColorsApp.grey400),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextButton(
                                              onPressed: () {
                                                Routes.instance.pushAndRemoveUntil(
                                                widget: PetLostForum(petId: widget.petId,),
                                                context: context,
                                                );
                                              },
                                              child: Text("Sí"),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            width: 1,
                                            color: ColorsApp.grey400,
                                          ),
                                          Expanded(
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("No"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                        },
                        icon: Icons.location_pin,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        '¿Se perdió tu mascota?',
                        style: TextsFont.tituloNames,
                      ),
                    ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}