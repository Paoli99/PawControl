import 'package:cloud_firestore/cloud_firestore.dart';

class UpdatePetInfo {
  final String userId;

  UpdatePetInfo({required this.userId});

  Future<void> updatePetInfo({
    required String petId,
    required String name,
    required String breed,
    required String color,
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
        'color': color,
        // Actualiza los demás campos de la mascota según sea necesario
      });
      print('Información de la mascota actualizada correctamente');
    } catch (e) {
      print("Error updating pet info: $e");
    }
  }
}
