// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/asset_images.dart';
import 'package:pawcontrol/constants/base.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/constants/routes.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/constants/constants.dart';
import 'package:pawcontrol/firebase/firebase_auth/firebase_auth.dart';
import 'package:pawcontrol/screens/auth_ui/forgotPass/forgotPass.dart';
import 'package:pawcontrol/screens/auth_ui/sign_up/signup.dart';
import 'package:pawcontrol/screens/home/home.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';
import 'package:pawcontrol/widgets/socialMediaBtn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}
  class _LoginPageState extends State<LoginPage>{

    bool _isPasswordVisible = true; 
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    @override
    Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
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
                "PAW LINK",
                style: TextsFont.tituloLogo),

              Container(
                margin: EdgeInsets.only(top: 20),
                width: 340, 
                height: 250,
                decoration: BoxDecoration(
                color: ColorsApp.white70,
                borderRadius: BorderRadius.circular(10), 
                ),
                

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

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
                    ),
                    
                    SizedBox(
                      height: 15.0,
                    ),

                    PrimaryButton(title: 'Iniciar Sesión', onPressed: () async{
                        bool isValidated =
                        loginValidation(context, email.text, password.text);
                        if (isValidated) {
                        bool isLogedin = await FirebaseAuthenticator.instance
                          .login(email.text, password.text, context);
                        if (isLogedin) {
                          Routes.instance.pushAndRemoveUntil(
                          widget: const Home(),
                          context: context,
                          );
                        }
                        }
                    },),
                    SizedBox(
                      height: 5.00,
                    ),
                    Padding(padding: EstilosBase.listPadding,
                            child: RichText(textAlign: TextAlign.center,
                            text: TextSpan(
                              text: '¿Olvidaste tu contraseña?',
                              style: TextsFont.cuerpo,
                              recognizer: TapGestureRecognizer()
                                ..onTap = (){
                                  Routes.instance.push(
                                    widget: ForgotPassword(),
                                    context: context,
                                    );
                                }
                            ),

                            ),
                            )
                  ],
                  
                ),
              ),
              //Login types
              SizedBox(height: 5.0),
              Center(
                child: Text('Inicia sesión con Facebook o Google',
                    style: TextsFont.suggestion),
              ),

              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocialMediaBtn(
                    textoRedes: 'Facebook',
                    tipoRedes: TipoRedes.Facebook,
                    onPressed: () {
                     
                    },
                  ),
                  SizedBox(width: 10), 
                  SocialMediaBtn(
                    textoRedes: 'Google',
                    tipoRedes: TipoRedes.Google,
                    onPressed: () {
                      
                    },
                  ),
                ],
              ),

              SizedBox(height: 5.0),

              Padding(padding: EstilosBase.listPadding,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: '¿Nuevo por aquí? ',
                    style: TextsFont.cuerpo,
                    children: [
                      TextSpan(
                        text: '¡Registrate ahora!',
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
            ],),
        ),
        ),
      
      ),
    );
  }
  }