// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/constants.dart';
import 'package:pawcontrol/constants/textFields.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/firebase/firebase_firestore/publishLostPet.dart';
import 'package:pawcontrol/screens/pets/pets.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/pictures/addPicture.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';
import 'package:path/path.dart' as Path;


class PetLostFoundForum extends StatefulWidget {
  final String petId;

  const PetLostFoundForum({Key? key, required this.petId}) : super(key: key);

  @override
  State<PetLostFoundForum> createState() => _PetLostFoundForumState();
}

class _PetLostFoundForumState extends State<PetLostFoundForum> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
  }

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      showLoaderDialog(context);
      try {
        String fileName = "lostPets/${DateTime.now().millisecondsSinceEpoch}_${Path.basename(pickedFile.path)}";
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
                  onPressed: pickImage
                ),
                SizedBox(height: 20.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextInputFields(
                      controller: nameController,
                      hintText: 'Ingrese el nombre de su mascota',
                      prefixIcon: Icon(
                        Icons.pets_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
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
