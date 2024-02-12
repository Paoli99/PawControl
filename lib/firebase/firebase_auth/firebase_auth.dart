// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:pawcontrol/constants/constants.dart';


class FirebaseAuthenticator {
  static FirebaseAuthenticator instance = FirebaseAuthenticator();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch(error) {
      Navigator.of(context).pop();
      showMessage(context, error.code.toString());
      return false;
    }
  }

    Future<bool> signUp(
    File? profilePicture, // Cambiado a File? para manejar casos donde no se sube ninguna imagen
    String firstName,
    String lastName,
    String phone,
    String address,
    String email,
    String password,
    String confirmPassword,
    BuildContext context,
  ) async {
    try {
      showLoaderDialog(context);

      String imageUrl = '';

      // Subir la imagen a Firebase Storage si se ha seleccionado una
      if (profilePicture != null) {
        imageUrl = await uploadImageToFirebaseStorage(context, profilePicture);
      }

      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      String userId = _auth.currentUser!.uid;

      // Guardar la URL de la imagen en Firestore si se ha subido una
      if (imageUrl.isNotEmpty) {
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'profilePicture': imageUrl,
          'firstName': firstName,
          'lastName': lastName,
          'phone': phone,
          'address': address,
          'email': email,
        });
      } else {
        // Si no se ha subido una imagen, guardar solo los otros datos del usuario en Firestore
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'firstName': firstName,
          'lastName': lastName,
          'phone': phone,
          'address': address,
          'email': email,
        });
      }

      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      showMessage(context, error.code.toString());
      return false;
    }
  }

  Future<String> uploadImageToFirebaseStorage(BuildContext context, File imageFile) async {
  try {
    Reference storageReference = FirebaseStorage.instance.ref().child('profilePictures').child(imageFile.path);
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    return await taskSnapshot.ref.getDownloadURL();
  } catch (error) {
    showMessage(context, 'Error al subir la imagen: $error');
    return '';
  }
}
  
  void signOut() async {
    await _auth.signOut();
  }

  Future<bool> passwordReset(String email, BuildContext context) async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (error){
      showMessage(context, error.code.toString());
      return false;
    }

  }

}

