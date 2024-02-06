// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      String firtName, String lastName, String phone, String address, String email, String password, String confirmPassword, BuildContext context) async {
    try {
      showLoaderDialog(context);
      
      await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
      
      String userId = _auth.currentUser!.uid;
      
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'firstName': firtName,
        'lastName': lastName,
        'phone': phone,
        'address': address,
        'email': email,
      });

      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch(error) {
      Navigator.of(context).pop();
      showMessage(context, error.code.toString());
      return false;
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
