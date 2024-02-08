// updateUserInfo.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateUserInfo {
  final String userId;

  UpdateUserInfo({required this.userId});

  Future<void> updateUserData({
    required String firstName,
    required String lastName,
    required String phone,
    required String address,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'address': address,
        // Aquí puedes agregar más campos si es necesario
      });
      print('Información del usuario actualizada correctamente');
    } catch (e) {
      print("Error updating user data: $e");
    }
  }
}
