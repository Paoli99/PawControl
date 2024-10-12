// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawcontrol/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:pawcontrol/firebase/firebase_FCM/firebase_notifications.dart';

Future<void> publishFoundPet({
  required BuildContext context,
  required String userId,
  required String species,
  required String breed,
  required String gender,
  required String date,
  required String location,
  required String description,
  required int phone,
  required List<String> imageUrls,
  required String publicationId,  

}) async {
  if (species.isEmpty ||
      breed.isEmpty ||
      gender.isEmpty ||
      date.isEmpty ||
      location.isEmpty ||
      description.isEmpty ||
      phone == 0 ||
      imageUrls.any((url) => url.isEmpty)) {
    showMessage(
        context, "Todos los campos deben estar completos, incluyendo la imagen de la mascota.");
    return;
  }

  showLoaderDialog(context);

  try {
    print("Attempting to publish found pet with the following details:");
    print("userId: $userId");
    print("species: $species");
    print("breed: $breed");
    print("gender: $gender");
    print("date: $date");
    print("location: $location");
    print("description: $description");
    print("phone: $phone");
    print("imageUrls: $imageUrls");
    print("publicationId: $publicationId");

    await FirebaseFirestore.instance.collection('foundPetsForms').doc(publicationId).set({
      'userId': userId,
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
        callCloudFunction(publicationId, 'found', 'automatic-search-2'),
        callCloudFunction(publicationId, 'found', 'description-search')
      ]).then((responses) {
        List<dynamic> imageResults = responses[0];
        List<dynamic> textResults = responses[1];

      String notificationMessage = (imageResults.isNotEmpty || textResults.isNotEmpty)
          ? "Se encontraron resultados"
          : "No se encontraron resultados";
      String notificationType = "foundPet";

      List<String> imagePostIds = imageResults.map((result) => result['post_id'].toString()).toList();
      List<String> textPostIds = textResults.map((result) => result['post_id'].toString()).toList();

      if (imageResults.isNotEmpty || textResults.isNotEmpty) {
        saveNotification(
          context,
          notificationMessage,
          notificationType,
          imagePostIds: imagePostIds,
          textPostIds: textPostIds,
          originalPostId: publicationId,
        );
      } else {
        saveNotification(context, notificationMessage, notificationType, originalPostId: publicationId);
      }
    });
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


