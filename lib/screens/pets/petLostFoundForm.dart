// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/textFields.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/screens/pets/pets.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/pictures/addPicture.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';

class PetLostFoundForum extends StatefulWidget {
  final String petId;

  const PetLostFoundForum({Key? key, required this.petId}) : super(key: key);

  @override
  State<PetLostFoundForum> createState() => _PetLostFoundForumState();
}

class _PetLostFoundForumState extends State<PetLostFoundForum> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  late User currentUser; // Variable para almacenar el usuario actual

  String imageUrl = "";

  @override
  void initState() {
    super.initState();
  }

  void setImageUrl(String url) {
    setState(() {
      imageUrl = url;
    });
  }

    void navigateBack(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Pets(petId: widget.petId,)),
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
                  onPressed: () {
                    // Aquí deberías implementar la lógica para que el usuario elija una imagen
                    // Puedes usar un método como pickImage de una librería como image_picker
                  },
                ),
                SizedBox(height: 20.0),
                // Datos del usuario
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextInputFields(
                      controller: address,
                      hintText: 'Ingrese el nombre de su mascota',
                      prefixIcon: Icon(
                        Icons.other_houses_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextInputFields(
                      controller: address,
                      hintText: 'Dia que se perdio',
                      prefixIcon: Icon(
                        Icons.other_houses_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextInputFields(
                      controller: address,
                      hintText: 'Descripcion de la mascota',
                      prefixIcon: Icon(
                        Icons.other_houses_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFields(
                      controller: phone,
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
