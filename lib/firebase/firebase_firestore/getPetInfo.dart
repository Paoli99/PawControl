import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetPetInfo {
  static Future<List<Map<String, dynamic>>> getUserPetsInfo() async {
    List<Map<String, dynamic>> userPets = [];

    try {
      // Obtener el usuario actual
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Obtener la referencia del documento del usuario actual
        DocumentSnapshot<Map<String, dynamic>> userDoc =
            await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        // Obtener la colección de mascotas del usuario
        CollectionReference petCollection = userDoc.reference.collection('pets');
        QuerySnapshot petSnapshot = await petCollection.get();
        
        // Iterar sobre los documentos de las mascotas y agregar la información al resultado
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
      // Obtener el usuario actual
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Obtener la referencia del documento de la mascota específica
        DocumentSnapshot<Map<String, dynamic>> petDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('pets')
            .doc(petId)
            .get();

        // Verificar si el documento existe
        if (petDoc.exists) {
          print('ID de la mascota: ${petDoc.id}');
          // Obtener la información de la mascota
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