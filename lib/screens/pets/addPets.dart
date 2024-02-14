import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/datePicker.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/pictures/addPicture.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';
import 'package:pawcontrol/constants/dropListView.dart';
import 'package:pawcontrol/constants/constants.dart';

class AddPets extends StatefulWidget {
  @override
  _AddPetsState createState() => _AddPetsState();
}

class _AddPetsState extends State<AddPets> {
  DateTime? selectedDate;
  String? selectedSpecies;
  TextEditingController petNameController = TextEditingController();
  TextEditingController petBreedController = TextEditingController();
  TextEditingController petGenderController = TextEditingController();
  TextEditingController petColorController = TextEditingController();
  String? imageUrl;

  List<String> dogBreeds = [
    'Mestizo',
    'Chihuahua',
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

  List<String> catBreeds = [
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

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void _setImageUrl(String imageUrl) {}

    List<String>? breedList =
        selectedSpecies == null ? null : (selectedSpecies == 'Perro' ? dogBreeds : catBreeds);

    List<DropdownMenuItem<String>> breedDropdownItems = breedList?.map((value) => DropdownMenuItem(
          value: value,
          child: Text(value),
        )).toList() ?? [];

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Header(title: 'PAW CONTROL', showImage: true, showBackButton: true),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 650,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Center(
                        child: AddPicture(
                          imageUrl: imageUrl ?? "",
                          setImageUrl: _setImageUrl,
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextInputFields(
                      controller: petNameController,
                      hintText: 'Ingrese el nombre de su mascota',
                      prefixIcon: Icon(
                        Icons.pets_outlined,
                        color: Colors.grey,
                      ),
                      backgroundColor: ColorsApp.white70,
                    ),
                    SizedBox(height: 20),
                    DropDownListView<String>(
                      label: 'Especie',
                      value: selectedSpecies,
                      items: ['Perro', 'Gato']
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSpecies = value!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    DropDownListView<String>(
                      label: 'Raza',
                      items: breedDropdownItems,
                      onChanged: (value) {
                        setState(() {
                          petBreedController.text = value ?? '';
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    DropDownListView<String>(
                      label: 'Sexo',
                      items: ['Macho', 'Hembra']
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          petGenderController.text = value ?? '';
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    DropDownListView<String>(
                      label: 'Color',
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
                          petColorController.text = value ?? '';
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: DatePickerField(
                        selectedDate: selectedDate,
                        onSelectDate: (DateTime? date) {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                        onTap: (context) {
                          _selectDate(context);
                        },
                        placeholderText: 'Seleccione la fecha de nacimiento',
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: PrimaryButton(
                        title: 'Registrar mascota',
                        onPressed: () async {
                          bool success = await registerPet(
                            context: context,
                            petName: petNameController.text,
                            selectedSpecies: selectedSpecies ?? '',
                            selectedBreed: petBreedController.text,
                            selectedSex: petGenderController.text,
                            selectedColor: petColorController.text,
                            imageUrl: imageUrl ?? '',
                            selectedDate: selectedDate ?? DateTime.now(),
                          );
                          if (success) {
                            // Aquí puedes navegar a la siguiente pantalla o realizar otras acciones
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
