// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/asset_images.dart';
import 'package:pawcontrol/constants/base.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/constants/routes.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';
import 'package:pawcontrol/widgets/socialMediaBtn.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}
  class _SignUpState extends State<SignUp>{

    bool _isPasswordVisible = true; 

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

                    TextInputFields(
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
                    PrimaryButton(title: 'Registrame', onPressed: (){},),
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
