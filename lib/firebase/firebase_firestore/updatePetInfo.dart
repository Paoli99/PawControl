import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawcontrol/constants/constants.dart';

class UpdatePetInfo {
  final String userId;
  final String petId;  
  final BuildContext context;

  UpdatePetInfo({required this.userId, required this.petId, required this.context});

  Future<void> updatePetInfo({
    required String name,
    required String species,
    required String breed,
    required String color,
    required String sex,
    required String weight,
    required String birthDate,
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
      showGoodMessage(context, 'Información de la mascota actualizada correctamente.');
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
      setImageUrl(downloadURL);

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('pets')
            .doc(petId) 
            .update({
          'imageUrl': downloadURL,
        });
        showGoodMessage(context, 'Imagen de la mascota actualizada correctamente.');
      } catch (e) {
        showMessage(context, "Error al actualizar la imagen de la mascota: $e");
      }

      return downloadURL;
    } else {
      showMessage(context, 'No se seleccionó ninguna imagen.');
      return null;
    }
  }
}
