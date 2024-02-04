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

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
                        onPressed: () {},
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