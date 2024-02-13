import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/datePicker.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';
import 'package:pawcontrol/constants/dropListView.dart';

class AddPets extends StatefulWidget {
  @override
  _AddPetsState createState() => _AddPetsState();
}

class _AddPetsState extends State<AddPets> {
  DateTime? selectedDate;

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

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Header(title: 'PAW CONTROL', showImage: true, showBackButton: true,),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 650,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextInputFields(
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
                      items: ['Perro', 'Gato', 'Otro']
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {
                      },
                    ),
                    SizedBox(height: 20),
                    DropDownListView<String>(
                      label: 'Raza',
                      items: ['Golden Retriever', 'Labrador Retriever', 'Bulldog', 'Otra']
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {
                        // Handle selection
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
                        // Handle selection
                      },
                    ),
                    SizedBox(height: 20),
                    DropDownListView<String>(
                      label: 'Color',
                      items: ['Blanco', 'Negro', 'Marrón', 'Otro']
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {
                        // Handle selection
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
                        placeholderText: 'Seleccione la fecha de nacimiento', // Define el texto del marcador de posición aquí
                      ),
                    ),
                    SizedBox(height: 20), 
                    Center( // Envuelve el botón en un Center
                      child: PrimaryButton(
                        title: 'Registrar mascota',
                        onPressed: () {
                          // Acción al presionar el botón
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
