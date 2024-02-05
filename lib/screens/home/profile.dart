// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/asset_images.dart';
import 'package:pawcontrol/constants/base.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/constants/listTitle.dart';
import 'package:pawcontrol/constants/routes.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/screens/home/home.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';
import 'package:pawcontrol/widgets/socialMediaBtn.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final int index;

  const Profile({Key? key, required this.index}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    //AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorsApp.white70,
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          "Editar Perfil",
                          style: TextsFont.tituloHeaderSmall,
                        ),
                      ),
                      Positioned(
                        right: 8.0,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.logout_outlined,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            setState(() {
                              
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 10),
                
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_outline,  // Usa Icons.person_outline para un ícono de persona
                      size: 150,
                    ) ,
                    Text(
                      "Paola Vilaseca",
                      style: TextStyle(
                        fontSize: 22, 
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      Text(
                      "paolavilaseca.r@gmail.com",
                      //appProvider.getUserInformation.email,
                      style: TextStyle(
                        fontSize: 15, 
                        fontWeight: FontWeight.normal,
                      ),
                      )
                  ],
                ),

                SizedBox(
                      height: 30.0,
                    ),

                Container(
                    child: Column(children: const[
                      CustomListTile(
                        leading: Icon(Icons.person_outlined),
                        title: "Editar tu información",
                      ),
                      CustomListTile(
                        leading: Icon(Icons.pets_outlined),
                        title: "Tus mascotas",
                      ),
                      CustomListTile(
                        leading: Icon(Icons.business_center_outlined),
                        title: "Sobre nosotros",
                      ),
                      CustomListTile(
                        leading: Icon(Icons.headphones_outlined),
                        title: "Soporte",
                      )
                    ]),
                  ),

                PrimaryButton(title: 'Actualizar Información', onPressed: () {

                },
                ),


                 SizedBox(height: 15.0),

                
              ],
            ),
            
          ),
        ),
      ),
    );
  }
}
