import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/constants.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/constants/routes.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/firebase/firebase_firestore/publishVetVisit.dart';
import 'package:pawcontrol/screens/pets/pets.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';

class AddVetVisit extends StatefulWidget {
  final String petId;

  const AddVetVisit({Key? key, required this.petId}) : super(key: key);

  @override
  _AddVetVisitState createState() => _AddVetVisitState();
}

class _AddVetVisitState extends State<AddVetVisit> {
  TextEditingController visitDateController = TextEditingController();
  TextEditingController visitMotiveController = TextEditingController();
  TextEditingController vetNameController = TextEditingController();

  String? userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void navigateBack(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Pets(petId: widget.petId)),
    );
  }

void getUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;  
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Header(
                title: 'PAW CONTROL',
                showImage: true,
                showBackButton: true,
                navigateTo: navigateBack,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Registrar Consulta Médica',
                      style: TextsFont.tituloNames,
                    ),
                    SizedBox(height: 20),
                    TextInputFields(
                      controller: vetNameController,
                      hintText: 'Nombre del veterinario',
                      prefixIcon: Icon(
                        Icons.pets_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(height: 20),
                    TextInputFields(
                      controller: visitDateController,
                      hintText: 'Fecha',
                      prefixIcon: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 350,
                      child: TextInputFields(
                        controller: visitMotiveController,
                        hintText: 'Motivo de la consulta',
                        prefixIcon: Icon(
                          Icons.medical_services_outlined,
                          color: Colors.grey,
                        ),
                        backgroundColor: ColorsApp.white70,
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: PrimaryButton(
                        title: 'Registrar consulta',
                        onPressed: () async {
                          bool isValid = await validateVetVisit(
                            context: context,
                            vetName: vetNameController.text,
                            visitDate: visitDateController.text,
                            visitMotive: visitMotiveController.text,
                          );

                          if (isValid) {
                            bool success = await Publishvetvisit.publishVetVisit(
                              context: context,
                              userId: userId!,
                              petId: widget.petId,
                              vetName: vetNameController.text,
                              visitDate: visitDateController.text,
                              visitMotive: visitMotiveController.text,
                            );

                            if (success) {
                              Routes.instance.pushAndRemoveUntil(
                                widget: Pets(petId: widget.petId),
                                context: context,
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
