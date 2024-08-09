// ignore_for_file: prefer_const_constructors, unused_local_variable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/constants.dart';
import 'package:pawcontrol/constants/textFields.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/firebase/firebase_firestore/publishLostPet.dart';
import 'package:pawcontrol/screens/pets/pets.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';


class PetLostForum extends StatefulWidget {
  final String petId;

  const PetLostForum({Key? key, required this.petId}) : super(key: key);

  @override
  State<PetLostForum> createState() => _PetLostForumState();
}

class _PetLostForumState extends State<PetLostForum> {
  TextEditingController nameController = TextEditingController();
  TextEditingController speciesController = TextEditingController();
  TextEditingController breedController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String imageUrl = "";
  List<String> vaccineImages = [];

  @override
  void initState() {
    super.initState();
    fetchPetData();
    loadVaccineImages();
  }

  void fetchPetData() async {
  try {
    if (widget.petId.isEmpty) {
      print("Pet ID is empty");
      return;
    }
    
    DocumentSnapshot petDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('pets')
        .doc(widget.petId)
        .get();

    if (petDoc.exists) {
      Map<String, dynamic> petData = petDoc.data() as Map<String, dynamic>;
      setState(() {
        nameController.text = petData['name'] ?? ''; 
        speciesController.text = petData['species'] ?? '';
        breedController.text = petData['breed'] ?? '';
        genderController.text = petData['sex'] ?? '';
      });
    } else {
      print("No se encontró la mascota con ID: ${widget.petId}");
    }
  } catch (e) {
    print("Error al cargar los datos de la mascota: $e");
  }
}



void loadVaccineImages() async {
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  List<String> loadedImages = [];


  for (int i = 0; i <= 2; i++) {
    String path = "petVaccinePhotos/${widget.petId}/${widget.petId}_$i.jpg";
    print(path);
     try {
      String imageUrl = await FirebaseStorage.instance.ref(path).getDownloadURL();
      loadedImages.add(imageUrl);
    } catch (e) {
      print("Error al cargar la imagen: $e");
    } 
  }

  setState(() {
    vaccineImages = loadedImages;
  });
}

/*   void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      showLoaderDialog(context);
      try {
        String fileName = "lostPets/${DateTime.now().millisecondsSinceEpoch}_${Path.basename(pickedFile.path)}";
        Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
        await storageRef.putFile(File(pickedFile.path));
        String downloadUrl = await storageRef.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
        Navigator.pop(context);
      } catch (e) {
        Navigator.pop(context);
        print(e);
      }
    }
  } */
  
  /* void setImageUrl(String path) {
    setState(() {
      imageUrl = path;
    });
  } */

    void navigateBack(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Pets(petId: widget.petId,)),
    );
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
                Header(
                  title: 'Formulario de mascota',
                  showImage: true,
                  showBackButton: true,
                  showLogoutButton: false,
                  navigateTo: navigateBack,
                ),
                SizedBox(height: 20.0),
                
                /* AddPicture(
                  imageUrl: imageUrl,
                  setImageUrl: setImageUrl,
                  onPressed: pickImage
                ), */

                if (vaccineImages.isNotEmpty)
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: vaccineImages.map((url) => Image.network(url, width: 100, height: 100)).toList(),
                    ),

                SizedBox(height: 20.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextInputFields(
                      controller: nameController,
                      prefixIcon: Icon(
                        Icons.pets_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextInputFields(
                      controller: speciesController,
                      prefixIcon: Icon(
                        Icons.pets_rounded,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(height: 15),
                    TextInputFields(
                      controller: breedController,
                      prefixIcon: Icon(
                        Icons.pets_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(height: 15),
                    TextInputFields(
                      controller: genderController,
                      prefixIcon: Icon(
                        Icons.pets_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(height: 20),
                    TextInputFields(
                      controller: dateController,
                      hintText: 'Dia que se perdio',
                      prefixIcon: Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextInputFields(
                      controller: locationController,
                      hintText: 'Ubicación',
                      prefixIcon: Icon(
                        Icons.pin_drop_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      height: 150,
                      decoration: BoxDecoration(
                        color: ColorsApp.grey300,
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: ColorsApp.grey300,
                            blurRadius: 25,
                          ),
                        ],
                        border: Border.all(color: Colors.transparent, width: 1.0),
                      ),
                      child: TextField(
                        controller: descriptionController,
                        maxLines: null,
                        minLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Descripcion detallada de la mascota',
                          prefixIcon: Icon(Icons.description_outlined, color: Colors.grey, size: 24), 
                          fillColor: ColorsApp.white70,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 10.0), 
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                      ),
                    ),

                    SizedBox(
                      height: 15.0,
                    ),
                    TextFields(
                      controller: phoneController,
                      hintText: 'Ingrese su numero de teléfono',
                      prefixIcon: Icon(
                        Icons.phone_iphone_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                      keyboardType: TextInputType.numberWithOptions(decimal: false),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                  ],
                ),
                PrimaryButton(
                  title: 'Publicar',
                  onPressed: () async {
                    bool success = await publishLostPet(
                      context: context,
                      name: nameController.text,
                      species: speciesController.text,
                      breed: breedController.text,
                      gender: genderController.text,
                      date: dateController.text,
                      location: locationController.text,
                      description: descriptionController.text,
                      phone: int.tryParse(phoneController.text) ?? 0, 
                      petId: widget.petId,
                      imageUrls: vaccineImages,
                    );
                    
                    if (success) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Pets(petId: widget.petId)));
                      showGoodMessage(context, "Mascota publicada correctamente");
                    } else {
                    
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
