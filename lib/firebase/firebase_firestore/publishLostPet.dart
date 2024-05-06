import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawcontrol/constants/constants.dart';

Future<void> publishLostPet({
  required BuildContext context,
  required String name,
  required String species,
  required String breed,
  required String gender,
  required String date,
  required String location,
  required String description,
  required int phone,
  required String imageUrl,
}) async {
  if (imageUrl.isEmpty || name.isEmpty || species.isEmpty || breed.isEmpty || gender.isEmpty || date.isEmpty || location.isEmpty || description.isEmpty || phone == 0) {
    showMessage(context, "Todos los campos deben estar completos, incluyendo la imagen de la mascota.");
    return;
  }

  showLoaderDialog(context);
  try {
    await FirebaseFirestore.instance.collection('lostPets').add({
      'name': name,
      'species': species,
      'breed': breed,
      'gender': gender,
      'date': date,
      'location': location,
      'description': description,
      'phone': phone,
      'imageURL': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
    });
    Navigator.pop(context);
    showGoodMessage(context, "La mascota perdida ha sido publicada exitosamente.");
  } catch (e) {
    Navigator.pop(context);
    showMessage(context, "Error al publicar la mascota perdida: $e");
  }
}
