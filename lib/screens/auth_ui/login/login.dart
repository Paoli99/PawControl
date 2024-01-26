// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/asset_images.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';
import 'package:pawcontrol/widgets/socialMediaBtn.dart';

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
                margin: EdgeInsets.only(top: 20),
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
                      height: 15.0,
                    ),
                    
                    PrimaryButton(title: 'Login', onPressed: (){},),
                    
                  ],
                  
                ),
              ),
              //Inicio de sesion alternativo 
              SizedBox(height: 5.0),
              Center(
                child: Text('Inicia sesión con Facebook o Google',
                    style: TextsFont.suggestion),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocialMediaBtn(
                    textoRedes: 'Facebook',
                    tipoRedes: TipoRedes.Facebook,
                    onPressed: () {
                      // Acción cuando se presiona el botón de Facebook
                    },
                  ),
                  SizedBox(width: 10), // Espacio entre los botones
                  SocialMediaBtn(
                    textoRedes: 'Google',
                    tipoRedes: TipoRedes.Google,
                    onPressed: () {
                      // Acción cuando se presiona el botón de Google
                    },
                  ),
                ],
              ),
            ],),
        )
      
      ),
    );
  }
}