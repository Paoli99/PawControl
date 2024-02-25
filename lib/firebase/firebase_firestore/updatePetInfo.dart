import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UpdatePetInfo {
  final String userId;
  final String petId;

  UpdatePetInfo({required this.petId, required this.userId});

  Future<void> updatePetData({
    required String petName,
    required String selectedSpecies,
    required String selectedBreed,
    required String selectedSex,
    required String selectedColor,
    required String petWeight,
    required DateTime selectedDate,
  }) async {
    try {
      String formattedDate = selectedDate.toIso8601String();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('pets')
          .doc(petId)
          .update({
        'name': petName,
        'species': selectedSpecies,
        'breed': selectedBreed,
        'sex': selectedSex,
        'color': selectedColor,
        'weight': petWeight,
        'birthDate': formattedDate,
      });
      print('Información de la mascota actualizada correctamente');
    } catch (e) {
      print("Error al actualizar la información de la mascota: $e");
      throw e;
    }
  }

  Future<void> updatePetImage(Function(String) setImageUrl) async {
  final image = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    maxHeight: 512,
    maxWidth: 512,
    imageQuality: 75,
  );

  if (image != null) {
    Reference ref = FirebaseStorage.instance.ref().child("petProfileImages").child("$petId.jpg");
    await ref.putFile(File(image.path));
    String downloadURL = await ref.getDownloadURL();
    print(downloadURL);
    setImageUrl(downloadURL);

    if (userId.isNotEmpty && petId.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('pets')
            .doc(petId)
            .update({'imageUrl': downloadURL});
        print('URL de imagen actualizada en Firestore.');
      } catch (e) {
        print('Error al actualizar la URL de la imagen en Firestore: $e');
        throw e;
      }
    } else {
      print('Error: userId o petId es nulo o vacío.');
    }
  } else {
    print('No se seleccionó ninguna imagen.');
  }
}
}
