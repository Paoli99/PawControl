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

  class Home extends StatefulWidget {
    const Home({Key? key});

    @override
    _HomeState createState() => _HomeState();
  }

  class _HomeState extends State<Home> {
    int _currentIndex = 0;

    final List<Widget> _children = [
      FirstPage(),
      SecondPage(),
      ThirdPage(),
    ];

    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            selectedItemColor: ColorsApp.deepPurple200,
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

    class FirstPage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return SingleChildScrollView(
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
                        onPressed: () {},
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
                        style: TextsFont.tituloHeader,
                      ),
                    ],
                  ),
                ),
                // Resto del contenido de la primera página
              ],
            ),
          ),
        );
      }
    }

      class SecondPage extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
          return Center(
            child: Text('Página de búsqueda'),
          );
        }
      }

      class ThirdPage extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
          return Center(
            child: Text('Página de perfil'),
          );
        }
}