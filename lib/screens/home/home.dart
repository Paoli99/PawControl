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


class Home extends StatelessWidget{
  const Home({super.key});

  @override
  Widget build(BuildContext context){
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

/*class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
}*/