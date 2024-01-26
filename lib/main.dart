import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/theme.dart';
import 'package:pawcontrol/screens/auth_ui/login/login.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PawControl', 
      theme: themeData,
      home: LoginPage()
      );
}
}
