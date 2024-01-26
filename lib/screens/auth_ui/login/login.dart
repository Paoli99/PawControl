// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/asset_images.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("PawLink"),
              SizedBox(
                height: 12,
              ),
              Text("PawLink"),
              Image.asset(AssetsImages.instance.logo),
            ],),
        )
      
      ),
    );
  }
}