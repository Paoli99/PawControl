import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/constants.dart';

class Publishvetvisit {
  static Future<bool> publishVetVisit({
    required BuildContext context,
    required String userId,
    required String petId,
    required String vetName,
    required String visitDate,
    required String visitMotive,
  }) async {
    if (userId.isEmpty || petId.isEmpty) {
      showMessage(context, "Error: Usuario o identificador de la mascota no puede estar vacío.");
      return false;
    }

    try {
      DocumentReference petDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('pets')
        .doc(petId);

      await petDoc.collection('clinicHistory').doc().set({
        'vetName': vetName,
        'visitDate': visitDate,
        'visitMotive': visitMotive,
      });

      showGoodMessage(context, "Consulta médica registrada con éxito.");
      return true;
    } catch (e) {
      showMessage(context, "Error al registrar la consulta médica: $e");
      return false;
    }
  }
}





