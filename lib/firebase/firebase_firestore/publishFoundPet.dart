// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawcontrol/constants/constants.dart';

Future<void> publishFoundPet({
  required BuildContext context,
  required String userId,
  required String species,
  required String breed,
  required String gender,
  required String date,
  required String location,
  required String description,
  required int phone,
  required List<String> imageUrls,
  required String publicationId,  
}) async {
  if (species.isEmpty ||
      breed.isEmpty ||
      gender.isEmpty ||
      date.isEmpty ||
      location.isEmpty ||
      description.isEmpty ||
      phone == 0 ||
      imageUrls.any((url) => url.isEmpty)) {
    showMessage(
        context, "Todos los campos deben estar completos, incluyendo la imagen de la mascota.");
    return;
  }

  showLoaderDialog(context);

  try {
    print("Attempting to publish found pet with the following details:");
    print("userId: $userId");
    print("species: $species");
    print("breed: $breed");
    print("gender: $gender");
    print("date: $date");
    print("location: $location");
    print("description: $description");
    print("phone: $phone");
    print("imageUrls: $imageUrls");
    print("publicationId: $publicationId");

    await FirebaseFirestore.instance.collection('foundPetsForms').doc(publicationId).set({
      'userId': userId,
      'species': species,
      'breed': breed,
      'gender': gender,
      'date': date,
      'location': location,
      'description': description,
      'phone': phone,
      'imageUrls': imageUrls,
      'createdAt': FieldValue.serverTimestamp(),
    });

    print("Document successfully written!");

    Navigator.pop(context);
    showGoodMessage(
        context, "La mascota perdida ha sido publicada exitosamente.");
  } catch (e) {
    Navigator.pop(context);
    print("Error publishing document: $e");
    showMessage(context, "Error al publicar la mascota perdida: $e");
  }
}

void showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
