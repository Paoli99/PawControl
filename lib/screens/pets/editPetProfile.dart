import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/textFields.dart';
import 'package:pawcontrol/firebase/firebase_firestore/updatePetInfo.dart';
import 'package:pawcontrol/screens/pets/pets.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/pictures/addPicture.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';
import 'package:pawcontrol/firebase/firebase_firestore/getPetInfo.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/constants/dropListView.dart';
import 'package:pawcontrol/constants/datePicker.dart';

class EditPetProfile extends StatefulWidget {
  final String petId; 
  const EditPetProfile({Key? key, required this.petId}) : super(key: key);

  @override
  State<EditPetProfile> createState() => _EditPetProfileState();
}

class _EditPetProfileState extends State<EditPetProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController breedController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController speciesController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  late UpdatePetInfo _updatePetInfo;
  List<Map<String, dynamic>> userPets = [];

  @override
  void initState() {
    super.initState();
    _updatePetInfo = UpdatePetInfo(userId: FirebaseAuth.instance.currentUser!.uid);
    loadPetInfo();
  }

  void navigateBack(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Pets(petId: widget.petId)),
  ); 
}

  Future<void> loadPetInfo() async {
    try {
    Map<String, dynamic> petInfo = await GetPetsInfo.getPetInfo(widget.petId);
    setState(() {
      nameController.text = petInfo['name'] ?? '';
      breedController.text = petInfo['breed'] ?? '';
      colorController.text = petInfo['color'] ?? '';
      userPets.add(petInfo); // Agregar la información de la mascota a la lista userPets
    });
  } catch (e) {
    print('Error al cargar la información de la mascota: $e');
  }
  }

  String imageUrl = "";

  void setImageUrl(String url) {
        setState(() {
          imageUrl = url;
        });
      }

  void updatePet() {
    _updatePetInfo.updatePetInfo(
      petId: widget.petId,
      name: nameController.text,
      breed: breedController.text,
      color: colorController.text,
      // Pasa más parámetros según sea necesario para otros campos de la mascota
    );
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
                navigateTo: navigateBack, // Define la ruta específica aquí
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  for (var petInfo in userPets)
                    Column(
                      children: [
                        AddPicture(imageUrl: petInfo['imageUrl'] ?? '', 
                        setImageUrl: setImageUrl,
                        onPressed: () {

                        }, 
                        ),
                        SizedBox(height: 20),
                        TextInputFields(
                          controller: nameController..text = petInfo['name'] ?? '',
                          hintText: 'Nombre',
                          prefixIcon: Icon(
                            Icons.pets_outlined,
                            color: Colors.grey,
                          ),
                          backgroundColor: ColorsApp.white70,
                        ),
                        SizedBox(height: 20),
                        DropDownListView<String>(
                          label: 'Especie',
                          value: petInfo['species'] ?? '',
                          items: ['Perro', 'Gato']
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              petInfo['species'] = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        DropDownListView<String>(
                          label: 'Raza',
                          value: petInfo['breed'] ?? '',
                          items: breedDropdownItems(petInfo['species']),
                          onChanged: (value) {
                            setState(() {
                              petInfo['breed'] = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        DropDownListView<String>(
                          label: 'Sexo',
                          value: petInfo['sex'] ?? '',
                          items: ['Macho', 'Hembra']
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              petInfo['sex'] = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        DropDownListView<String>(
                          label: 'Color',
                          value: petInfo['color'] ?? '',
                          items: [
                            'Blanco',
                            'Negro',
                            'Marrón',
                            'Gris',
                            'Beige',
                            'Naranja',
                            'Atigrado',
                            'Tricolor',
                            'Gris Azulado',
                            'Blanco y negro',
                            'Otro',
                          ]
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              petInfo['color'] = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            // Implementar lógica para seleccionar la fecha de nacimiento
                          },
                          child: DatePickerField(
                            selectedDate: DateTime.parse(petInfo['birthDate'] ?? ''),
                            onSelectDate: (DateTime? date) {
                              setState(() {
                                petInfo['birthDate'] = date.toString();
                              });
                            },
                            onTap: (context) {
                              // Implementar lógica para seleccionar la fecha de nacimiento
                            },
                            placeholderText: 'Fecha de nacimiento',
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFields(
                          controller: weightController..text = petInfo['weight'] ?? '',
                          hintText: 'Peso',
                          prefixIcon: Icon(
                            Icons.monitor_weight_outlined,
                            color: Colors.grey,
                          ),
                          backgroundColor: ColorsApp.white70,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                        ),
                        SizedBox(height: 20),
                        PrimaryButton(
                          title: 'Actualizar Mascota',
                          onPressed: updatePet,
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> breedDropdownItems(String? species) {
    List<String>? breedList = species == null ? null : (species == 'Perro' ? dogBreeds : catBreeds);

    return breedList?.map((value) => DropdownMenuItem(
          value: value,
          child: Text(value),
        )).toList() ?? [];
  }

  static const List<String> dogBreeds = [
    'Mestizo',
    'Chihuahua',
    'Cooker',
    'Bulldog',
    'Labrador Retriever',
    'Golden Retriever',
    'Pastor Alemán',
    'Boxer',
    'Shih Tzu',
    'Pomerania',
    'Yorkshire Terrier',
    'Otra',
  ];

  static const List<String> catBreeds = [
    'Mestizo',
    'Siamés',
    'Persa',
    'Maine Coon',
    'Ragdoll',
    'Bengal',
    'British Shorthair',
    'Scottish Fold',
    'Sphynx',
    'Otro',
  ];

}