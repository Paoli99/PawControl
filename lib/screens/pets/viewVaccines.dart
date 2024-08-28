// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/constants/routes.dart';
import 'package:pawcontrol/screens/pets/addVaccines.dart';
import 'package:pawcontrol/screens/pets/pets.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/secondary_buttons/roundButtons.dart';

class Vaccine {
  final String nextVaccineDate;
  final String productName;
  final String vaccineDate;
  final String vaccineName;

  Vaccine({
    required this.nextVaccineDate,
    required this.productName,
    required this.vaccineDate,
    required this.vaccineName,
  });

  factory Vaccine.fromFirestore(Map<String, dynamic> data) {
    return Vaccine(
      nextVaccineDate: data['nextVaccineDate'] ?? '',
      productName: data['productName'] ?? '',
      vaccineDate: data['vaccineDate'] ?? '',
      vaccineName: data['vaccineName'] ?? '',
    );
  }
}

class ViewVaccines extends StatefulWidget {
  final String petId;

  const ViewVaccines({Key? key, required this.petId}) : super(key: key);

  @override
  _ViewVaccinesState createState() => _ViewVaccinesState();
}

class _ViewVaccinesState extends State<ViewVaccines> {
  List<Vaccine> vaccines = [];

  @override
  void initState() {
    super.initState();
    loadVaccines();
    loadVaccineImages();
  }

  void loadVaccines() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('pets')
        .doc(widget.petId)
        .collection('vaccines')
        .get();

    List<Vaccine> loadedVaccines = snapshot.docs
        .map((doc) => Vaccine.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList();

    setState(() {
      vaccines = loadedVaccines;
    });
  }

  List<String> vaccineImages = [];

  void loadVaccineImages() async {
    List<String> loadedImages = [];

    for (int i = 0; i <= 2; i++) {
      String path = "petVaccinePhotos/${widget.petId}/${widget.petId}_$i.jpg";
      print(path);
      try {
        String imageUrl = await FirebaseStorage.instance.ref(path).getDownloadURL();
        loadedImages.add(imageUrl);
      } catch (e) {
        print("Error al cargar la imagen: $e");
      }
    }

    setState(() {
      vaccineImages = loadedImages;
    });
  }

  void navigateBack(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Pets(petId: widget.petId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Header(title: 'Vacunas', showImage: true, showBackButton: true, navigateTo: navigateBack),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                    SizedBox(height: 20),
                    if (vaccineImages.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: vaccineImages.map((url) => Image.network(url, width: 100, height: 100)).toList(),
                      ),
                    SizedBox(height: 20),
                    if (vaccines.isNotEmpty)
                      ...vaccines.map((vaccine) => Card(
                            child: ListTile(
                              title: Text(vaccine.vaccineName, style: TextStyle(color: ColorsApp.redAccent400, fontWeight: FontWeight.bold, fontSize: 20)),
                              subtitle: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Nombre del producto: ', style: TextStyle(color: ColorsApp.black, fontWeight: FontWeight.bold, fontSize: 16)),
                                    TextSpan(text: '${vaccine.productName}\n', style: TextStyle(color: ColorsApp.black, fontWeight: FontWeight.normal, fontSize: 16)),
                                    TextSpan(text: 'Fecha de vacunación: ', style: TextStyle(color: ColorsApp.black, fontWeight: FontWeight.bold, fontSize: 16)),
                                    TextSpan(text: '${vaccine.vaccineDate}\n', style: TextStyle(color: ColorsApp.black, fontWeight: FontWeight.normal, fontSize: 16)),
                                    TextSpan(text: 'Fecha de próxima vacuna: ', style: TextStyle(color: ColorsApp.black, fontWeight: FontWeight.bold, fontSize: 16)),
                                    TextSpan(text: '${vaccine.nextVaccineDate}', style: TextStyle(color: ColorsApp.black, fontWeight: FontWeight.normal, fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                          ))
                          .toList(),
                    if (vaccines.isEmpty)
                      Text('No hay vacunas disponibles.'),
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
