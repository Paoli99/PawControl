// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pawcontrol/constants/constants.dart';
import 'package:pawcontrol/models/userModel.dart';


class FirebaseAuthenticator {
  static FirebaseAuthenticator instance = FirebaseAuthenticator();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

  Future<bool> signUp( String firstName, String lastName, String phone, String address, String email,
      String password, String confirmPassword, BuildContext context,
    ) async {
      try {
        showLoaderDialog(context);
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        UserModel userModel = UserModel(
          id: userCredential.user!.uid,
          name: firstName + ' ' + lastName,
          email: email,
          image: '',
        );

        await _firestore.collection("users").doc(userModel.id).set(userModel.toJson());

        Navigator.of(context).pop();
        return true;
      } on FirebaseAuthException catch (error) {
        Navigator.of(context).pop();
        showMessage(context, error.code.toString());
        return false;
      }
    }

  void signout() async{
    await _auth.signOut();
  }
}
