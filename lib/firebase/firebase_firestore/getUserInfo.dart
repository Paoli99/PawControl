// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserInfo {
  final String userId;

  GetUserInfo({required this.userId});

  Future<Map<String, dynamic>> getUserData() async {
    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        return userData;
      } else {
        return {};
      }
    } catch (e) {
      print("Error getting user data: $e");
      return {};
    }
  }
}
