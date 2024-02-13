// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pawcontrol/widgets/header/header.dart';

class AddPets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Header(title: 'PAW CONTROL', showImage: true, showBackButton: true,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
