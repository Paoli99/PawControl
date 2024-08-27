// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/asset_images.dart';
import 'package:pawcontrol/constants/base.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/constants.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/firebase/firebase_auth/firebase_auth.dart';
import 'package:pawcontrol/screens/auth_ui/login/login.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final email = TextEditingController();
  
  @override
  void dispose() { 
    email.dispose();
    super.dispose();
  }
   @override
  void navigateBack(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage())
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                /* Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: ColorsApp.white70,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_outlined),
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
                ), */
                Header(
                title: 'PAW LINK',
                showImage: true,
                showBackButton: true,
                navigateTo: navigateBack
              ),
              SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    
                    children: [

                      SizedBox(
                      height: 50.0,
                      ),

                      Image.asset(
                        AssetsImages.instance.lock,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),

                      Padding(
                        padding: EstilosBase.listPadding,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: '¿Tienes problemas para iniciar sesión? ',
                            style: TextsFont.forgotPass,
                          ),
                        ),
                      ),

                      Padding(
                        padding: EstilosBase.listPadding,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                'Ingresa tu correo electrónico y te enviaremos un link para cambiar tu contraseña.',
                            style: TextsFont.cuerpo,
                          ),
                        ),
                      ),

                      SizedBox(height: 10.0),
                      TextInputFields(
                        controller: email,
                        hintText: 'Ingrese su correo',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                        ),
                        backgroundColor: ColorsApp.white70,
                      ),
                      SizedBox(height: 10.0),
                      SizedBox(height: 10.0),
                      PrimaryButton(
                        title: 'Cambiar Contraseña',
                        onPressed: () async {
                          String userEmail = email.text;
                          
                          try {
                            bool isEmailValid = await isValidEmail(context, userEmail);

                            if (isEmailValid) {
                              bool resetResult = await FirebaseAuthenticator.instance.passwordReset(userEmail, context);

                              if (resetResult) {
                                showGoodMessage(context, "Correo enviado.");
                              } else {
                                showMessage(context, "No se pudo enviar el correo de restablecimiento.");
                              }
                            } else {
                              // No es necesario mostrar un mensaje aquí, ya que isValidEmail maneja los mensajes de error.
                            }
                          } catch (e) {
                            print('Error al cambiar la contraseña: $e');
                          }
                        },
                      ),
                      SizedBox(height: 5.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}