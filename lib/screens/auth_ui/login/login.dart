// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/asset_images.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';

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
              
              SizedBox(
                height: 50,
              ),
              
              Align(
                child: Image.asset(
                  alignment: Alignment.bottomCenter,
                  AssetsImages.instance.logo,
                  width: 250,
                  height: 250,
                  fit:BoxFit.fill),
              ),

              Text(
                "PAW CONTROL",
                style: TextsFont.tituloLogo),

              Container(
                margin: EdgeInsets.only(top: 40),
                width: 340, // set the width of the container
                height: 250, // set the height of the container
                decoration: BoxDecoration(
                color: ColorsApp.white70,
                borderRadius: BorderRadius.circular(10), // set border radius to make it circular
                ),
                

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    
                     SizedBox(
                      height: 20.0,
                    ),
                    
                    PrimaryButton(title: 'Login'),

                    SizedBox(
                      height: 20.0,
                    ),
                      
                    
                  ],
                ),
              )
            ],),
        )
      
      ),
    );
  }
}