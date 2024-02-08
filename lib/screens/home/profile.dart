// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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

  @override
  void initState() {
    super.initState();
    // Llama a la función para obtener la información del usuario al inicio
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    try {
      // Verifica si el usuario está autenticado
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Crea una instancia de GetUserInfo y llama a getUserData
        GetUserInfo getUserInfoInstance = GetUserInfo(userId: user.uid);
        Map<String, dynamic> userInfo = await getUserInfoInstance.getUserData();
        print('Usuario ID: ${user.uid}');
        print('Información del usuario: $userInfo');
        // Actualiza los controladores de texto con la información del usuario
        setState(() {
        firstName.text = userInfo['firstName'] ?? '';
        lastName.text = userInfo['lastName'] ?? '';
        phone.text = userInfo['phone'] ?? '';
        address.text = userInfo['address'] ?? '';
        print('userInfo: $userInfo'); // Agrega este print para verificar el contenido de userInfo
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
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 150,
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      child: Column(
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
