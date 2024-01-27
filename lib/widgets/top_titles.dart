import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/fonts.dart';

class TopTitles extends StatelessWidget{

  final String title;
  const TopTitles({super.key, required this.title});

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: kToolbarHeight + 12,
        ),

        if(title == "¡Crea una cuenta!") const BackButton(),

        Text(
          title,
          style: TextsFont.titulos,
        )
      ],
    );
  }
}