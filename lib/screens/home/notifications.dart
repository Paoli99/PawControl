import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/screens/pets/viewResults.dart';
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
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  const Header(
                    title: 'Notificaciones',
                    showImage: true,
                    showBackButton: false,
                    showLogoutButton: false,
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('notifications')
                        .orderBy('createdAt', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            "Sin notificaciones",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var notification = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                            bool isClickable = notification['message'] == "Se encontraron resultados";

                            return GestureDetector(
                              onTap: isClickable
                                  ? () {
                                      String notificationType = notification['notificationType'] ?? '';
                                      if (notificationType == 'lostPet' || notificationType == 'foundPet') {
                                        List<String> imagePostIds = List<String>.from(notification['imagePostIds'] ?? []);
                                        List<String> textPostIds = List<String>.from(notification['textPostIds'] ?? []);
                                        String originalPostId = notification['originalPostId'] ?? '';

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ViewResults(
                                              imagePostIds: imagePostIds,
                                              textPostIds: textPostIds,
                                              originalPostId: originalPostId,
                                              notificationType: notificationType,
                                            ),
                                          ),
                                        );
                                      } else {
                                        print('Otro tipo de notificación');
                                      }
                                    }
                                  : null,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                color: Colors.transparent,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: isClickable
                                        ? () {
                                            String notificationType = notification['notificationType'] ?? '';
                                            if (notificationType == 'lostPet' || notificationType == 'foundPet') {
                                              List<String> imagePostIds = List<String>.from(notification['imagePostIds'] ?? []);
                                              List<String> textPostIds = List<String>.from(notification['textPostIds'] ?? []);
                                              String originalPostId = notification['originalPostId'] ?? '';

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => ViewResults(
                                                    imagePostIds: imagePostIds,
                                                    textPostIds: textPostIds,
                                                    originalPostId: originalPostId,
                                                    notificationType: notificationType,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              print('Otro tipo de notificación');
                                            }
                                          }
                                        : null,
                                    highlightColor: isClickable ? ColorsApp.deepPurple100 : Colors.transparent,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: ColorsApp.deepPurple100,
                                              child: Icon(Icons.notifications, color: ColorsApp.deepPurple400),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                notification['message'],
                                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios, size: 16, color: ColorsApp.grey400),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
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
