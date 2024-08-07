import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

Future<void> compareImagesAndNotify(String userId, String targetImageUrl) async {
  // Descargar la imagen de la mascota perdida
  File targetImageFile = await downloadImage(targetImageUrl);

  List<String> foundImageUrls = await getFoundPetImageUrls();

  for (String foundImageUrl in foundImageUrls) {
    File foundImageFile = await downloadImage(foundImageUrl);

    bool isSimilar = await compareImages(targetImageFile, foundImageFile);

    if (isSimilar) {
      await createNotification(userId, foundImageUrl);
    }
  }
}

Future<File> downloadImage(String imageUrl) async {
  final response = await http.get(Uri.parse(imageUrl));
  final documentDirectory = await getApplicationDocumentsDirectory();

  File file = File('${documentDirectory.path}/temp.jpg');
  file.writeAsBytesSync(response.bodyBytes);
  return file;
}

Future<List<String>> getFoundPetImageUrls() async {
  List<String> foundImageUrls = [];
  
  ListResult result = await FirebaseStorage.instance.ref('foundPetFormPhotos').listAll();

  for (var prefix in result.prefixes) {
    ListResult imagesResult = await prefix.listAll();

    for (var imageRef in imagesResult.items) {
      //solo se comparara 1 imagen 
      if (imageRef.name.endsWith('_0.jpg')) {
        String imageUrl = await imageRef.getDownloadURL();
        foundImageUrls.add(imageUrl);
      }
    }
  }
  
  return foundImageUrls;
}

Future<bool> compareImages(File targetImage, File foundImage) async {
  return false; 
}

Future<void> createNotification(String userId, String foundImageUrl) async {
  await FirebaseFirestore.instance.collection('notifications').add({
    'userId': userId,
    'message': 'Se ha encontrado una mascota similar a la suya.',
    'imageUrl': foundImageUrl,
    'createdAt': FieldValue.serverTimestamp(),
  });
}
