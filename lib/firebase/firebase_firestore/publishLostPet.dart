import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawcontrol/constants/constants.dart';
import 'package:pawcontrol/firebase/firebase_firestore/compareImagesAndNotify.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

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
}) async {
  if (name.isEmpty || species.isEmpty || breed.isEmpty || gender.isEmpty || date.isEmpty || location.isEmpty || description.isEmpty || phone == 0 || imageUrls.isEmpty) {
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
      Navigator.of(context).pop();  
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

      // Sube las imágenes a Firebase Storage
      for (String imageUrl in imageUrls) {
        try {
          
          String fileName = path.basename(Uri.decodeComponent(imageUrl.split('?').first));
          
          // Descargar la imagen 
          var response = await http.get(Uri.parse(imageUrl));
          if (response.statusCode == 200) {
            var tempDir = await getTemporaryDirectory();
            File tempFile = File('${tempDir.path}/$fileName');
            await tempFile.writeAsBytes(response.bodyBytes);
            String storagePath = "lostPetFormPhotos/$petId/$fileName";
            Reference storageRef = FirebaseStorage.instance.ref().child(storagePath);
            await storageRef.putFile(tempFile);

            print("Imagen subida a: $storagePath");
          } else {
            print("Error al descargar la imagen: ${response.statusCode}");
          }
        } catch (e) {
          print("Error al procesar la imagen: $e");
        }
      }

      createNotificationForLostPet(petId, userId);
      Navigator.of(context).pop();  
      return true;
    }
  } catch (e) {
    Navigator.of(context).pop();  
    showMessage(context, "Error al publicar la mascota: $e");
    return false;
  }
}

void createNotificationForLostPet(String petId , String userId) {
  // Espacio  para la lógica de notificaciones
  print("Notificación creada para la mascota perdida con ID: $petId de usuario $userId");
}
