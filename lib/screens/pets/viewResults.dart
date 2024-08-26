// viewResults.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/widgets/header/header.dart';

class ViewResults extends StatelessWidget {
  final String originalPostId;
  final List<String> postIds;
  final String notificationType;

  const ViewResults({
    Key? key,
    required this.originalPostId,
    required this.postIds,
    required this.notificationType,
  }) : super(key: key);

  Future<DocumentSnapshot> fetchOriginalPost(String postId) async {
    String collection = notificationType == 'lostPet' ? 'lostPetsForms' : 'foundPetsForms';
    return await FirebaseFirestore.instance.collection(collection).doc(postId).get();
  }

  Future<List<DocumentSnapshot>> fetchResults(List<String> postIds) async {
    List<DocumentSnapshot> results = [];
    String collection = notificationType == 'lostPet' ? 'foundPetsForms' : 'lostPetsForms';
    for (String id in postIds) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection(collection).doc(id).get();
      if (snapshot.exists) {
        results.add(snapshot);
      }
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Header(
                title: 'Resultados',
                showImage: true,
                showBackButton: true,
                showLogoutButton: false,
                navigateTo: (context) => Navigator.of(context).pop(), // Volver atrás
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Publicación original",
                    style: TextStyle(
                      color: ColorsApp.rojoGoogle,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              FutureBuilder<DocumentSnapshot>(
                future: fetchOriginalPost(originalPostId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Center(child: Text('No se encontró el post original.'));
                  } else {
                    var post = snapshot.data!.data() as Map<String, dynamic>;
                    return buildPostCard(post);
                  }
                },
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Publicaciones similares",
                    style: TextStyle(
                      color: ColorsApp.rojoGoogle,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              FutureBuilder<List<DocumentSnapshot>>(
                future: fetchResults(postIds),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No se encontraron resultados.'));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var post = snapshot.data![index].data() as Map<String, dynamic>;
                        return buildPostCard(post);
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPostCard(Map<String, dynamic> post) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
            child: Image.network(
              post['imageUrls'].isNotEmpty ? post['imageUrls'][0] : 'https://via.placeholder.com/150',
              width: 120,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(width: 100, height: 100, color: ColorsApp.grey300, child: Icon(Icons.broken_image));
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDetailRow("Raza:", post['breed'] ?? 'Raza no especificada'),
                  buildDetailRow("Género:", post['gender'] ?? 'Género no especificado'),
                  buildDetailRow("Fecha:", post['date'] ?? 'Fecha no especificada'),
                  buildDetailRow("Ubicación:", post['location'] ?? 'Ubicación no especificada'),
                  buildDetailRow("Descripción:", post['description'] ?? 'Descripción no disponible'),
                  buildDetailRow("Teléfono:", post['phone']?.toString() ?? 'Teléfono no especificado'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: ColorsApp.black),
        children: [
          TextSpan(text: "$label ", style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: value, style: TextStyle(fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }
}
