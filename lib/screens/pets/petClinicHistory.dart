import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/screens/pets/pets.dart';
import 'package:pawcontrol/widgets/header/header.dart';

class ClinicVisit {
  final String visitDate;
  final String visitMotive;
  final String vetName;
  final String detail;

  ClinicVisit({
    required this.visitDate,
    required this.visitMotive,
    required this.vetName,
    this.detail = '',
  });

  factory ClinicVisit.fromFirestore(Map<String, dynamic> data) {
    return ClinicVisit(
      visitDate: data['visitDate'] as String? ?? '',
      visitMotive: data['visitMotive'] as String? ?? '',
      vetName: data['vetName'] as String? ?? 'Desconocido',
      detail: data['detail'] as String? ?? '',
    );
  }
}

class PetClinicHistory extends StatefulWidget {
  final String petId;

  const PetClinicHistory({Key? key, required this.petId}) : super(key: key);

  @override
  _PetClinicHistoryState createState() => _PetClinicHistoryState();
}

class _PetClinicHistoryState extends State<PetClinicHistory> {
  List<ClinicVisit> clinicVisits = [];

  @override
  void initState() {
    super.initState();
    loadClinicHistory();
  }

  void loadClinicHistory() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('pets')
        .doc(widget.petId)
        .collection('clinicHistory')
        .get();

    List<ClinicVisit> loadedVisits = snapshot.docs
        .map((doc) => ClinicVisit.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList();

    setState(() {
      clinicVisits = loadedVisits;
    });
  }

  void navigateBack(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Pets(petId: widget.petId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Header(title: 'Historial Médico', showImage: true, showBackButton: true, navigateTo: navigateBack),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    ...clinicVisits.map((visit) => InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(visit.vetName, style: TextStyle(color: Colors.red)),
                              content: Text("Fecha: ${visit.visitDate}\nMotivo: ${visit.visitMotive}"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('Cerrar'),
                                ),
                              ],
                            ),
                          );
                        },

                      child: Card(
                        child: ListTile(
                          title: Text(visit.vetName, style: TextStyle(color: Colors.red)),
                          subtitle: Text("Fecha: ${visit.visitDate}\nMotivo: ${visit.visitMotive}"),
                        ),
                      ),
                    )).toList(),
                    if (clinicVisits.isEmpty)
                      Center(child: Text('No hay registros clínicos disponibles.', style: TextStyle(fontSize: 16))),
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
