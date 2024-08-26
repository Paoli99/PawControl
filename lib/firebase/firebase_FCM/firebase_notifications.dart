import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void saveNotification(BuildContext context, String message, String notificationType, {List<String>? postIds, required String originalPostId}) {
  final userId = FirebaseAuth.instance.currentUser?.uid;

  if (userId != null) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .add({
      'message': message,
      'notificationType': notificationType,  
      'postIds': postIds,
      'originalPostId': originalPostId,  
      'createdAt': FieldValue.serverTimestamp(),
    });
  } else {
    print("Error: No se pudo guardar la notificación porque el usuario no está autenticado.");
  }
}
