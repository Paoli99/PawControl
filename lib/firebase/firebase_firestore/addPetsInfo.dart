// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously

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
    required DateTime selectedDate,
  }) async {
    try {
      // Obtener el ID del usuario actualmente autenticado
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Obtener la referencia del documento del usuario actual
      final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

      // Crear la subcolección "mascotas" si no existe
      await userDoc.collection('mascotas').doc().set({
        'petName': petName,
        'selectedSpecies': selectedSpecies,
        'selectedBreed': selectedBreed,
        'selectedSex': selectedSex,
        'selectedColor': selectedColor,
        'imageUrl': imageUrl,
        'selectedDate': selectedDate,
      });

      return true;
    } catch (e) {
      print('Error al registrar la mascota: $e');
      return false;
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
      Reference ref = FirebaseStorage.instance.ref().child("profilePet.jpg");
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
