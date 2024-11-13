// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, override_on_non_overriding_member, annotate_overrides, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/constants.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/constants/routes.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/firebase/firebase_firestore/addVacinesInfo.dart';
import 'package:pawcontrol/screens/pets/pets.dart';
import 'package:pawcontrol/screens/pets/viewVaccines.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';

class AddVaccines extends StatefulWidget {
  final String petId;

  const AddVaccines({Key? key, required this.petId}) : super(key: key);

  @override
  _AddVaccinesState createState() => _AddVaccinesState();
}

class _AddVaccinesState extends State<AddVaccines> {
  TextEditingController vaccineController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController vaccineDateController = TextEditingController();
  TextEditingController nextVaccineDateController = TextEditingController();
  List<String> imageUrls = ['','',''];  
  bool _isPickerActive = false;

  String? userId;

  @override
  void initState() {
    super.initState();
    getUserId();  
  }

  void getUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;  
    }
  }
  
  @override
  void navigateBack(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewVaccines(petId: widget.petId)),
    );
  }

  Future<void> handleImageSelection(int index) async {
    if(_isPickerActive) return; 

    setState(() {
      _isPickerActive = true;
    });

    String? imageUrl = await AddVaccinesInfo.pickAndUploadImage(widget.petId, index.toString());
    if (imageUrl != null) {
      setState(() {
        imageUrls[index] = imageUrl;
      });
    }

    setState(() {
      _isPickerActive = false;
    });
  }

Widget imagePlaceholder(int index, String title, String defaultImagePath) {
  bool isBackImage = index == 2;
  double imageSize = isBackImage ? 100 : 100;  
  return Column(
    children: [
      Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      InkWell(
        onTap: () => handleImageSelection(index),
        child: Container(
          width: 100,  
          height: 100,  
          decoration: BoxDecoration(
            color: Colors.grey[300],
            border: Border.all(color: Colors.grey),
          ),
          child: Center(
            child: imageUrls[index].isEmpty
                ? Image.asset(
                    defaultImagePath,
                    fit: BoxFit.contain,  
                    width: imageSize, 
                    height: imageSize
                  )
                : Image.network(imageUrls[index], fit: BoxFit.cover),
          ),
        ),
      ),
    ],
  );
}

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Header(title: 'Registrar Vacunas', showImage: true, showBackButton: true, navigateTo: navigateBack),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    TextInputFields(controller: vaccineController, hintText: 'Tipo de vacuna', prefixIcon: Icon(Icons.pets_outlined, color: Colors.grey), backgroundColor: ColorsApp.white70),
                    SizedBox(height: 20),
                    TextInputFields(controller: productNameController, hintText: 'Nombre del producto', prefixIcon: Icon(Icons.pets_outlined, color: Colors.grey), backgroundColor: ColorsApp.white70),
                    SizedBox(height: 20),
                    TextInputFields(controller: vaccineDateController, hintText: 'Fecha de vacunación', prefixIcon: Icon(Icons.calendar_today, color: Colors.grey), backgroundColor: ColorsApp.white70),
                    SizedBox(height: 20),
                    TextInputFields(controller: nextVaccineDateController, hintText: 'Fecha de la siguiente vacuna', prefixIcon: Icon(Icons.calendar_today, color: Colors.grey), backgroundColor: ColorsApp.white70),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        imagePlaceholder(0, 'Frente', 'assets/icons/FrontDog.png'),
                        imagePlaceholder(1, 'Costado', 'assets/icons/SideDog.png'),
                        imagePlaceholder(2, 'Espalda', 'assets/icons/BackDog.png'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: PrimaryButton(
                        title: 'Registrar vacuna',
                        onPressed: () async {
                        bool isValid = await validateVaccineForm(
                          context: context,
                          vaccineName: vaccineController.text,
                          productName: productNameController.text,
                          vaccineDate: vaccineDateController.text,
                          nextVaccineDate: nextVaccineDateController.text,
                          imageUrls: imageUrls,
                        );

                        if (isValid) {
                          bool success = await AddVaccinesInfo.registerVaccine(
                            userId: userId!, 
                            petId: widget.petId,
                            vaccineName: vaccineController.text,
                            productName: productNameController.text,
                            vaccineDate: vaccineDateController.text,
                            nextVaccineDate: nextVaccineDateController.text,
                            imageUrls: imageUrls,
                          );

                          if (success) {
                            Routes.instance.pushAndRemoveUntil(
                              widget: ViewVaccines(petId: widget.petId,),
                              context: context,
                            );
                          }
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
