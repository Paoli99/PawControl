// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddVaccinesInfo {
  static Future<bool> registerVaccine({
    required String userId, 
    required String petId,
    required String vaccineName,
    required String vaccineDate,
    required String nextVaccineDate,
    required List<String> imageUrls, 
    required String productName,
  }) async {
    try {
     
      DocumentReference petDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('pets')
          .doc(petId);

      await petDoc.collection('vaccines').doc().set({
        'vaccineName': vaccineName,
        'productName': productName,  
        'vaccineDate': vaccineDate,
        'nextVaccineDate': nextVaccineDate,
        'imageUrls': imageUrls,
      });

      return true;
    } catch (e) {
      print('Error al registrar la vacuna: $e');
      print('UserID: $userId, PetID: $petId');
      return false;
    }
  }

  static Future<String?> pickAndUploadImage(String petId, String position) async {
    String imageName = '$petId/${petId}_$position.jpg';

    Reference ref = FirebaseStorage.instance.ref().child("petVaccinePhotos/$imageName");

    try {
      await ref.delete();
    } catch (e) {
      print("No se encontró archivo existente para borrar: $e");
    }

    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 75,
    );

    if (image != null) {
      await ref.putFile(File(image.path));
      String downloadURL = await ref.getDownloadURL();
      print(downloadURL);

      return downloadURL;
    } else {
      print('No se seleccionó ninguna imagen.');
      return null;
    }
  }
}
