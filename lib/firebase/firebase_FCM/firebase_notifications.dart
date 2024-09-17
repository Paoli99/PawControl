import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void saveNotification(BuildContext context, String message, String notificationType, {List<String>? imagePostIds, List<String>? textPostIds, required String originalPostId}) {
  final userId = FirebaseAuth.instance.currentUser?.uid;

  if (userId != null) {
    print('Saving notification with message: $message');
    print('Image Post IDs: $imagePostIds');
    print('Text Post IDs: $textPostIds');
    print('Original Post ID: $originalPostId');

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .add({
      'message': message,
      'notificationType': notificationType,  
      'imagePostIds': imagePostIds,
      'textPostIds': textPostIds,
      'originalPostId': originalPostId,  
      'createdAt': FieldValue.serverTimestamp(),
    }).then((_) {
      print('Notification saved successfully.');
    }).catchError((error) {
      print('Failed to save notification: $error');
    });
  } else {
    print("Error: No se pudo guardar la notificación porque el usuario no está autenticado.");
  }
}
