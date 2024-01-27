import 'package:flutter/material.dart';
import 'package:pawcontrol/widgets/top_titles.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children:  const [
            TopTitles(title: "¡Crea una cuenta!")   
          ],
        ),
      ),
    );
  }
}