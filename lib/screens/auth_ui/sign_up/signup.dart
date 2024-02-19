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
  class _SignUpState extends State<SignUp> {
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
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white70,
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
                        style: TextsFont.tituloHeader,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 480,
                  height: 650,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 15.0),
                      TextInputFields(
                        controller: firtName,
                        hintText: 'Ingrese su nombre',
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
                          color: Colors.grey,
                        ),
                        backgroundColor: Colors.white70,
                      ),
                      SizedBox(height: 15.0),
                      TextInputFields(
                        controller: lastName,
                        hintText: 'Ingrese su apellido',
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
                          color: Colors.grey,
                        ),
                        backgroundColor: Colors.white70,
                      ),
                      SizedBox(height: 15.0),
                      TextFields(
                        controller: phone,
                        hintText: 'Ingrese su número de teléfono',
                        prefixIcon: Icon(
                          Icons.phone_iphone_outlined,
                          color: Colors.grey,
                        ),
                        backgroundColor: Colors.white70,
                        keyboardType: TextInputType.numberWithOptions(decimal: false),

                      ),
                      SizedBox(height: 15.0),
                      TextInputFields(
                        controller: address,
                        hintText: 'Ingrese su dirección',
                        prefixIcon: Icon(
                          Icons.other_houses_outlined,
                          color: Colors.grey,
                        ),
                        backgroundColor: Colors.white70,
                      ),
                      SizedBox(height: 15.0),
                      TextInputFields(
                        controller: email,
                        hintText: 'Ingrese su correo',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                        ),
                        backgroundColor: Colors.white70,
                      ),
                      SizedBox(height: 15.0),
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
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        backgroundColor: Colors.white70,
                      ),
                      SizedBox(height: 15.0),
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
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        backgroundColor: Colors.white70,
                      ),

                      SizedBox(height: 15.0),
                      PrimaryButton(
                        title: 'Registrarme',
                        onPressed: () async {
                          bool isValidated = signUpValidation(
                            context,
                            firtName.text,
                            lastName.text,
                            phone.text,
                            address.text,
                            email.text,
                            password.text,
                            confirmPassword.text,
                          );
                          if (isValidated) {
                            bool isLogedin = await FirebaseAuthenticator.instance.signUp(
                              firtName.text,
                              lastName.text,
                              phone.text,
                              address.text,
                              email.text,
                              password.text,
                              confirmPassword.text,
                              context,
                            );
                            if (isLogedin) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                            }
                          }
                        },
                      ),
                      SizedBox(height: 5.0),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: '¿Ya tienes una cuenta? ',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: '¡Inicia sesión!',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pop(context);
                                  },
                              )
                            ],
                          ),
                        ),
                      ),
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