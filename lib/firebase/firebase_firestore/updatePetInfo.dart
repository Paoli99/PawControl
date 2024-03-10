import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart'; // Importa el paquete Material para acceder al contexto
import 'package:image_picker/image_picker.dart';
import 'package:pawcontrol/constants/constants.dart'; // Importa las funciones showMessage y showGoodMessage

class UpdatePetInfo {
  final String userId;
  final BuildContext context; // Agrega el contexto como propiedad de la clase

  UpdatePetInfo({required this.userId, required this.context}); // Actualiza el constructor para incluir el contexto

  Future<void> updatePetInfo({
    required String petId,
    required String name,
    required String species,
    required String breed,
    required String color,
    required String sex,
    required String weight,
    required String birthDate,
    required BuildContext context,

    // Agrega más parámetros según sea necesario para otros campos de la mascota
  }) async {
    try {

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('pets')
          .doc(petId)
          .update({
        'name': name,
        'breed': breed,
        'species': species,
        'color': color,
        'sex': sex,
        'weight': weight,
        'birthDate': birthDate,
      });
      showGoodMessage(context, 'Información de la mascota actualizada correctamente en la base de datos');
    } catch (e) {
      showMessage(context, 'Error al actualizar la información de la mascota: $e');
    }
  }

  Future<String?> pickAndUploadImage(Function(String) setImageUrl) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 75,
    );

    if (image != null) {
      Reference ref = FirebaseStorage.instance.ref().child("petProfileImages/${userId}/${DateTime.now().millisecondsSinceEpoch}.jpg");
      await ref.putFile(File(image.path));
      String downloadURL = await ref.getDownloadURL();
      print(downloadURL);
      setImageUrl(downloadURL);

      // Actualizar la URL de la imagen en Firestore
      try {
        await FirebaseFirestore.instance.collection('pets').doc(userId).update({
          'imageUrl': downloadURL,
        });
        print('Imagen de la mascota actualizada correctamente');
      } catch (e) {
        print("Error al actualizar la imagen de la mascota: $e");
      }

      return downloadURL;
    } else {
      print('No image selected.');
      return null;
    }
  }
}
