import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawcontrol/constants/constants.dart';

Future<bool> publishLostPet({
  required BuildContext context,
  required String petId,
  required String name,
  required String species,
  required String breed,
  required String gender,
  required String date,
  required String location,
  required String description,
  required int phone,
  required List<String> imageUrls, 

  //
  //required String imageUrl,
}) async {
  if (species.isEmpty || breed.isEmpty || gender.isEmpty || date.isEmpty || location.isEmpty || description.isEmpty || phone == 0 || imageUrls.isEmpty) {
    showMessage(context, "Por favor, llene todos los campos.");
    return false;
  }

  showLoaderDialog(context);

  try {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Verifica si ya existe una publicación para esta mascota
    DocumentSnapshot petSnapshot = await FirebaseFirestore.instance
        .collection('lostPetsForms')
        .doc(petId)
        .get();

    if (petSnapshot.exists) {
      showMessage(context, "Mascota ya publicada");
      return false;
    } else {
      await FirebaseFirestore.instance.collection('lostPetsForms').doc(petId).set({
        'userId': userId,
        'petId': petId, 
        'name': name,
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
      

      //espacio para la lógica de notificaciones

      createNotificationForLostPet(petId, userId);

      //Navigator.of(context).pop();
      return true;
    }
  } catch (e) {
    showMessage(context, "Error al publicar la mascota: $e");
    return false;
  }
}


void createNotificationForLostPet(String petId , String userId) {
  // Espacio  para la lógica de notificaciones
  print("Notificación creada para la mascota perdida con ID: $petId de usuario $userId");
}
