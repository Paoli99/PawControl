import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pawcontrol/constants/routes.dart';
import 'package:pawcontrol/screens/home/home.dart';

class FirebaseAuthenticator {
  static FirebaseAuthenticator instance = FirebaseAuthenticator();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }
}
