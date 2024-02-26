import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; // Importa el paquete Material para acceder al contexto
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
}
