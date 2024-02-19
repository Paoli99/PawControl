import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPetsInfo {
  static Future<bool> registerPet({
    required BuildContext context,
    required String petName,
    required String selectedSpecies,
    required String selectedBreed,
    required String selectedSex,
    required String selectedColor,
    required String imageUrl,
    required String petWeight,
    required DateTime selectedDate,
  }) async {
    try {
      // Obtener el ID del usuario actualmente autenticado
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Obtener la referencia del documento del usuario actual
      final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

      // Crear la subcolección "mascotas" si no existe
      await userDoc.collection('mascotas').doc().set({
        'name': petName,
        'species': selectedSpecies,
        'breed': selectedBreed,
        'sex': selectedSex,
        'color': selectedColor,
        'weight': petWeight,
        'imageUrl': imageUrl,
        'birthDate': selectedDate,
      });

      return true;
    } catch (e) {
      print('Error al registrar la mascota: $e');
      return false;
    }
  }

  static Future<String?> pickAndUploadImage(Function(String) setImageUrl) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 75,
    );

    if (image != null) {
      // Generar un nombre único para la imagen
      String imageName = '${DateTime.now().millisecondsSinceEpoch}_${image.path.split('/').last}';

      Reference ref = FirebaseStorage.instance.ref().child("petProfileImages/$imageName");
      await ref.putFile(File(image.path));
      String downloadURL = await ref.getDownloadURL();
      print(downloadURL);
      setImageUrl(downloadURL);

      return downloadURL;
    } else {
      print('No image selected.');
      return null;
    }
  }
}
