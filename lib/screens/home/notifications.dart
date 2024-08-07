// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawcontrol/widgets/header/header.dart';

class Notifications extends StatelessWidget {
  final int index;

  const Notifications({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Header(
                  title: 'Notificaciones',
                  showImage: true,
                  showBackButton: false,
                  showLogoutButton: false,
                ),
                SizedBox(height: 20),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('notifications')
                      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Text(
                        "Sin notificaciones",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var notification = snapshot.data!.docs[index];
                          return ListTile(
                            leading: Image.network(notification['imageUrl']),
                            title: Text(notification['message']),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
