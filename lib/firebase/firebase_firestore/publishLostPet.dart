import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawcontrol/constants/constants.dart'; 

Future<void> publishLostPet({
  required BuildContext context,
  required String name,
  required String date,
  required String location,
  required String description,
  required int phone,
  required String imageUrl,
}) async {
  
  showLoaderDialog(context); // Mostrar diálogo de carga

  try {
    // Guardar los datos en Firestore, incluyendo la URL de la imagen
    await FirebaseFirestore.instance.collection('lostPets').add({
      'name': name,
      'date': date,
      'location': location,
      'description': description,
      'phone': phone,
      'imageURL': imageUrl, // Usa la URL de la imagen
    });

    Navigator.pop(context); // Cerrar diálogo de carga
    showGoodMessage(context, "La mascota perdida ha sido publicada exitosamente.");
  } catch (e) {
    Navigator.pop(context); // Cerrar diálogo de carga si ocurre un error
    showMessage(context, "Error al publicar la mascota perdida: $e");
  }
}
