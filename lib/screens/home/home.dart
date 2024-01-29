import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/asset_images.dart';
import 'package:pawcontrol/constants/base.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/constants/routes.dart';
import 'package:pawcontrol/constants/textInputFields.dart';
import 'package:pawcontrol/widgets/primary_buttons/primary_button.dart';
import 'package:pawcontrol/widgets/socialMediaBtn.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: ColorsApp.white70,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 10),
                      Image.asset(
                        AssetsImages.instance.logo,
                        width: 60,
                        height: 60,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "PAW CONTROL",
                        style: TextsFont.tituloHeader
                      ),
                    ],
                  ),
                ),



                
              ]
            ),
            
          ),
      
        ),
      ),
    );
  }
}