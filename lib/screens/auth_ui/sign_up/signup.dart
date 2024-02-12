// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pawcontrol/constants/asset_images.dart';
import 'package:pawcontrol/constants/base.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/constants.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/constants/routes.dart';
import 'package:pawcontrol/constants/textFields.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/firebase/firebase_auth/firebase_auth.dart';
import 'package:pawcontrol/screens/home/home.dart';

import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';
import 'package:pawcontrol/widgets/secondary_buttons/secondarty_buttons.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}
  class _SignUpState extends State<SignUp>{

    bool _isPasswordVisible = true; 
    File? _image;

    TextEditingController firtName = TextEditingController();
    TextEditingController lastName = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();

    @override
    Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
                            
            Container(
              width: double.infinity, // Establece el ancho del contenedor al ancho total de la pantalla
              height: 100,
              decoration: BoxDecoration(
                color: ColorsApp.white70,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 10),
                  Image.asset(
                    AssetsImages.instance.logo,
                    width: 60,
                    height: 60,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "PAW CONTROL",
                    style: TextsFont.tituloHeader
                  ),
                ],
              ),
            ),
              Container(
                //margin: EdgeInsets.only(top: 20),
                width: 480, // set the width of the container
                height: 650, // set the height of the container

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(
                      height: 15.0,
                    ),
                    
                    TextInputFields(
                      controller: firtName,
                      hintText: 'Ingrese su nombre',
                      prefixIcon: Icon(
                        Icons.person_2_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),

                     SizedBox(
                      height: 15.0,
                    ),

                    TextInputFields(
                      controller: lastName,
                      hintText: 'Ingrese su apellido',
                      prefixIcon: Icon(
                        Icons.person_2_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                                        
                     SizedBox(
                      height: 15.0,
                    ),

                    TextFields(
                      controller: phone,
                      hintText: 'Ingrese su numero de teléfono',
                        prefixIcon: Icon(
                          Icons.phone_iphone_outlined,
                          color: Colors.grey,
                        ),
                        backgroundColor: ColorsApp.white70,
                      ),
                      

                    SizedBox(
                      height: 15.0,
                    ),

                    TextInputFields(
                      controller: address,
                      hintText: 'Ingrese su dirección',
                      prefixIcon: Icon(
                        Icons.other_houses_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                                        
                     SizedBox(
                      height: 15.0,
                    ),
                    TextInputFields(
                      controller: email,
                      hintText: 'Ingrese su correo',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                                        
                     SizedBox(
                      height: 15.0,
                    ),


                    TextInputFields(
                      controller: password,
                      hintText: 'Ingrese su contraseña',
                      obscureText: _isPasswordVisible,
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: Colors.grey,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    
                    SizedBox(
                      height: 15.0,
                    ),

                    TextInputFields(
                      controller: confirmPassword,
                      hintText: 'Confirme su contraseña',
                      obscureText: _isPasswordVisible,
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: Colors.grey,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(
                      height: 15.00,
                    ),
                    SecondaryButton(
                      title: 'Seleccionar imagen de perfil', 
                      onPressed: (){
                      },
                    ),
                    SizedBox(
                      height: 15.00,
                    ),
                    PrimaryButton(title: 'Registrame', onPressed: () async{
                      bool isValidated =
                        signUpValidation(context, 
                        firtName.text,
                        lastName.text,
                        phone.text,
                        address.text,
                        email.text, 
                        password.text,
                        confirmPassword.text);
                        if (isValidated) {
                        bool isLogedin = await FirebaseAuthenticator.instance
                          .signUp(
                          _image,
                          firtName.text,
                          lastName.text,
                          phone.text,
                          address.text,
                          email.text,
                          password.text,
                          confirmPassword.text,
                          context);
                        if (isLogedin) {
                          Routes.instance.pushAndRemoveUntil(
                          widget: const Home(),
                          context: context,
                          );
                        }
                      }
                      },
                    ),
                    SizedBox(
                      height: 5.00,
                    ),
                    SizedBox(height: 5.0),

                    Padding(padding: EstilosBase.listPadding,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: '¿Ya tienes una cuenta? ',
                          style: TextsFont.cuerpo,
                          children: [
                            TextSpan(
                              text: '¡Inicia sesión!',
                              style: TextsFont.link,
                              recognizer: TapGestureRecognizer()
                              ..onTap= () {
                                  Routes.instance.push(
                                    widget: SignUp(),
                                    context: context,
                                  );
                                },
                            )
                          ]
                        ),),
                      )
                  ],
                  
                ),
              ),
              

              
            ],),
        ),
        ),
      
      ),
    );
  }
  }
