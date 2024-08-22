/* import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void handleCloudFunctionResponse(String response, String userId) {
  print("Respuesta recibida: $response"); 
  List<String> matchedPostIds = response.split(',');

  if (matchedPostIds.isNotEmpty && matchedPostIds.first.isNotEmpty) {
    print("===============================");
    print("Match IDs: ${matchedPostIds.join(', ')}");
    print("===============================");
    for (var postId in matchedPostIds) {
      FirebaseFirestore.instance.collection('notifications').add({
        'userId': userId,
        'message': '¡Se encontró una coincidencia para su mascota perdida!',
        'matchedPostId': postId,
      }).then((value) => print("Notification added for postId $postId"))
        .catchError((error) => print("Failed to add notification for postId $postId: $error"));
    }
  } else {
    print("No se encontraron coincidencias.");
  }
}
 */