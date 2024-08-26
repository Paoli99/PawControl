// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/widgets/header/header.dart';

class Notifications extends StatefulWidget {
  final int index;

  const Notifications({Key? key, required this.index}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  Future<void> _refreshNotifications() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _refreshNotifications,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
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
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('notifications') 
                        .orderBy('createdAt', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            "Sin notificaciones",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var notification = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: () {
                                // Acciones al tocar la notificación
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                color: Colors.transparent, // Color de fondo original
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      // Acciones al tocar la notificación
                                    },
                                    highlightColor: ColorsApp.deepPurple100, // Color al hacer click
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: ColorsApp.deepPurple100,
                                              child: Icon(Icons.notifications, color: ColorsApp.deepPurple400),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                notification['message'],
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios, size: 16, color: ColorsApp.grey400),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          notification['createdAt'] != null
                                              ? (notification['createdAt'] as Timestamp).toDate().toString()
                                              : '',
                                          style: TextStyle(fontSize: 12, color: ColorsApp.grey600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
      ),
    );
  }
}
