import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawcontrol/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:convert';

import 'package:pawcontrol/firebase/firebase_FCM/firebase_notifications.dart';

Future<void> publishLostPet({
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
    return;
  }

  showLoaderDialog(context);

  try {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Verify if post already exists
    DocumentSnapshot petSnapshot = await FirebaseFirestore.instance
        .collection('lostPetsForms')
        .doc(petId)
        .get();

    if (petSnapshot.exists) {
      Navigator.of(context).pop();  
      showMessage(context, "Mascota ya publicada");
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


      // Send post_type and post_id 
      Future.wait([
        callCloudFunction(petId, 'lost', 'automatic-search-2'),
        callCloudFunction(petId, 'lost', 'description-search')
      ]).then((responses) {
        List<dynamic> imageResults = responses[0];
        List<dynamic> textResults = responses[1];

        Navigator.of(context).pop();


        // Send notification
        String notificationMessage = (imageResults.isNotEmpty || textResults.isNotEmpty)
            ? "Se encontraron resultados"
            : "No se encontraron resultados";
        String notificationType = "lostPet";


        List<String> imagePostIds = imageResults.map((result) => result['post_id'].toString()).toList();
        List<String> textPostIds = textResults.map((result) => result['post_id'].toString()).toList();

        if (imageResults.isNotEmpty || textResults.isNotEmpty) {
          saveNotification(
            context,
            notificationMessage,
            notificationType,
            imagePostIds: imagePostIds,
            textPostIds: textPostIds,
            originalPostId: petId,
          );
        } else {
          saveNotification(
            context, 
            notificationMessage, 
            notificationType, 
            originalPostId: petId
          );
        }
      }).catchError((e) {
        Navigator.of(context).pop();
        showMessage(context, "Error en la búsqueda de coincidencias: $e");
      });
    }
  } catch (e) {
    Navigator.pop(context);
    showMessage(context, "Error al publicar la mascota perdida: $e");
  }
}

Future<List<dynamic>> callCloudFunction(String postId, String postType, String functionUrl) async {
  var response = await http.post(
    Uri.parse('https://southamerica-east1-pawcontrol-432921.cloudfunctions.net/$functionUrl'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'post_type': postType,
      'post_id': postId,
    }),
  );

  if (response.statusCode == 200) {
    try {
      var results = jsonDecode(response.body);
      
      if (results is Map<String, dynamic> && results.containsKey('results')) {
        return results['results'];
      } else if (results is List) {
        return results;
      } else {
        print("Formato inesperado de resultados.");
        return [];
      }
    } catch (e) {
      print("Error al decodificar la respuesta JSON: $e");
      return [];
    }
  } else {
    print("Error en la llamada a la función en la nube: ${response.statusCode}");
    return [];
  }
}

void showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
