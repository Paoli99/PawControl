// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/constants.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/constants/routes.dart';
import 'package:pawcontrol/constants/textFields.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/firebase/firebase_firestore/getUserInfo.dart';
import 'package:pawcontrol/screens/auth_ui/login/login.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';
import 'package:pawcontrol/firebase/firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  final int index;

  const Profile({Key? key, required this.index}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  late User currentUser; // Variable para almacenar el usuario actual

  String imageUrl = "";
   @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        getUserInfo();
      } else {
      
      }
      });
      }

      void setImageUrl(String url) {
        setState(() {
          imageUrl = url;
        });
      }

      Future<void> getUserInfo() async {
        try {
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            GetUserInfo getUserInfoInstance = GetUserInfo(userId: user.uid);
            Map<String, dynamic> userInfo = await getUserInfoInstance.getUserData();
            setState(() {
              firstName.text = userInfo['firstName'] ?? '';
              lastName.text = userInfo['lastName'] ?? '';
              phone.text = userInfo['phone'] ?? '';
              address.text = userInfo['address'] ?? '';
              imageUrl = userInfo['imageUrl'] ?? ''; // Agrega la URL de la imagen si está disponible
            });
          } else {
            print('Usuario no autenticado');
          }
        } catch (e) {
          print('Error al obtener información del usuario: $e');
        }
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
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Routes.instance.pushAndRemoveUntil(
                                widget: LoginPage(), context: context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(
                  height: 20.0,
                ),
                
                Stack(
                children: [
                  Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(width: 4, color: Colors.white70),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: Colors.black87.withOpacity(0.1)
                      )
                    ],
                    shape: BoxShape.circle,
                  ),
                    child: ClipOval(
                      child: imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person, // Icono de persona
                            size: 100, // Tamaño del ícono
                            color: ColorsApp.white70, // Color del ícono
                          ),
                    ),  
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 4,
                          color: ColorsApp.white70
                        ),
                        color: ColorsApp.grey400
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.edit,
                          color: ColorsApp.white,
                        ),
                        onPressed: () {  
                          FirebaseAuthenticator firebaseAuthenticator = FirebaseAuthenticator();
                          firebaseAuthenticator.pickUpLoadImage(setImageUrl);
                        },
                      ),
                    ),
                  ),
                ],
              ),


                SizedBox(
                  height: 20.0,
                ),

                //Datos usuario

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextInputFields(
                      controller: firstName,
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
                      height: 25.0,
                    ),
                    
                    PrimaryButton(
                      title: 'Actualizar Información',
                      onPressed: () {
                        String userId = FirebaseAuth.instance.currentUser!.uid;

                        String updatedFirstName = firstName.text;
                        String updatedLastName = lastName.text;
                        String updatedPhone = phone.text;
                        String updatedAddress = address.text;
                        
                        updateUserInfo(
                          userId: userId,
                          firstName: updatedFirstName,
                          lastName: updatedLastName,
                          phone: updatedPhone,
                          address: updatedAddress,
                          context: context,
                        );
                      },
                    ),
                  ],
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
