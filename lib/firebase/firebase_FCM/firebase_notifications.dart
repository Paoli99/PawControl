// firebase_notifications.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void saveNotification(BuildContext context, String message) {
  final userId = FirebaseAuth.instance.currentUser?.uid;

  if (userId != null) {
    print("Notificación guardada: $message");

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('notifications')  
        .add({
      'message': message,
      'createdAt': FieldValue.serverTimestamp(),
    });
  } else {
    print("Error: No se pudo guardar la notificación porque el usuario no está autenticado.");
  }
}
