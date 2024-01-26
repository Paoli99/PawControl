import 'package:flutter/material.dart';
import 'package:pawcontrol/screens/auth_ui/login/login.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PawControl', 
      home: LoginPage()
      );
}
}
