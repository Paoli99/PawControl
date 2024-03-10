import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/theme.dart';
import 'package:pawcontrol/firebase/firebase_auth/firebase_auth.dart';
import 'package:pawcontrol/firebase/firebase_options/firebase_option.dart';
import 'package:pawcontrol/screens/auth_ui/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pawcontrol/screens/home/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseConfig.platformOptions, 
    );
  await FirebaseAppCheck.instance.activate();  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PawControl', 
      theme: themeData,
      home: StreamBuilder(
          stream: FirebaseAuthenticator.instance.getAuthChange,
          builder: (context, snapshot){
            if (snapshot.hasData){
              return const Home();
            }
            return const LoginPage();
          },
      )
      );
}
}
