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
                    
                    TextInputFields(
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
                        .loginValidation(email.text, password.text, context);
                        if (isLogedin) {
                        Routes.instance.pushAndRemoveUntil(
                        widget: Home(),
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
              //Inicio de sesion alternativo 
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