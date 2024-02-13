// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/asset_images.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/screens/home/profile.dart';
import 'package:pawcontrol/screens/home/search.dart';
import 'package:pawcontrol/screens/pets/addPets.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/secondary_buttons/roundButtons.dart';

class Home extends StatefulWidget {
  final int initialIndex;

  const Home({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  void initState() {

    //AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    //appProvider.getUserInfoFirebase();
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    switch (_currentIndex) {
      case 0:
        body = HomeContent();
        break;
      case 1:
        body = Search(index: 1);
        break;
      case 2:
        body = Profile(index: 2);
        break;
      default:
        body = Container(); // Puedes cambiar esto según tus necesidades
    }

    return SafeArea(
      child: Scaffold(
        body: body,
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Buscar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Header(title: 'PAW CONTROL', 
              showImage: true, 
              showBackButton: false,),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Flexible(
                      child: RoundButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddPets()),
                          );
                        },
                        icon: Icons.add,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Agregar mascotas',
                      style: TextStyle(fontSize: 16.0),
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
