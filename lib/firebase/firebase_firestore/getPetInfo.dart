import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetPetInfo {
  static Future<List<Map<String, dynamic>>> getUserPetsInfo() async {
    List<Map<String, dynamic>> userPets = [];

    try {
      // get current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> userDoc =
            await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        CollectionReference petCollection = userDoc.reference.collection('pets');
        QuerySnapshot petSnapshot = await petCollection.get();
        
        petSnapshot.docs.forEach((petDoc) {
          Map<String, dynamic> petInfo = {
            'id': petDoc.id,
            'name': petDoc['name'],
            'imageUrl': petDoc['imageUrl'],
          };
          userPets.add(petInfo);
          print('ID de la mascota: ${petDoc.id}');
        });
      }
    } catch (e) {
      print('Error al obtener la información de las mascotas del usuario: $e');
    }

    return userPets;
  }
}

class GetPetsInfo {
  static Future<Map<String, dynamic>> getPetInfo(String petId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get document reference for a specific pet
        DocumentSnapshot<Map<String, dynamic>> petDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('pets')
            .doc(petId)
            .get();

        if (petDoc.exists) {
          print('ID de la mascota: ${petDoc.id}');
          // Get pet's information
          Map<String, dynamic> petInfo = petDoc.data()!;
          return petInfo;
        } else {
          throw 'La mascota con ID $petId no existe.';
        }
      } else {
        throw 'No se pudo obtener el usuario actual.';
      }
    } catch (e) {
      print('Error al obtener la información de la mascota: $e');
      rethrow;
    }
  }
}