import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:279513317809:ios:4048ec90d2b6425f7c3d90',
        apiKey: 'AIzaSyB7QYkvWveLisqwL8DeG4mVAybJmVlgLqM',
        projectId: 'pawlink-94100',
        messagingSenderId: '279513317809',
        iosBundleId: 'com.example.pawcontrol',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:279513317809:android:de90b511769d45cf7c3d90',
        apiKey: 'AIzaSyAhOSERTLEDjJxg1fXtPWItWPd4fAiMHPY',
        projectId: 'pawlink-94100',
        messagingSenderId: '279513317809',
      );
    }
  }
}