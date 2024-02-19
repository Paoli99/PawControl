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
        CollectionReference petCollection = userDoc.reference.collection('mascotas');
        QuerySnapshot petSnapshot = await petCollection.get();
        
        // Iterar sobre los documentos de las mascotas y agregar la información al resultado
        petSnapshot.docs.forEach((petDoc) {
          Map<String, dynamic> petInfo = {
            'name': petDoc['petName'],
            'imageUrl': petDoc['imageUrl'],
            // Agrega más campos si es necesario
          };
          userPets.add(petInfo);
        });
      }
    } catch (e) {
      print('Error al obtener la información de las mascotas del usuario: $e');
    }

    return userPets;
  }
}
