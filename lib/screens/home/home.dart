// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/asset_images.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/constants/routes.dart';
import 'package:pawcontrol/screens/home/notifications.dart';
import 'package:pawcontrol/screens/home/profile.dart';
import 'package:pawcontrol/screens/home/search.dart';
import 'package:pawcontrol/screens/pets/addPets.dart';
import 'package:pawcontrol/screens/pets/pets.dart';
import 'package:pawcontrol/widgets/header/header.dart';
import 'package:pawcontrol/widgets/secondary_buttons/roundButtons.dart';
import 'package:pawcontrol/firebase/firebase_firestore/getPetInfo.dart'; // Importar el archivo getPetInfo.dart

class Home extends StatefulWidget {
  final int initialIndex;

  const Home({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Map<String, dynamic>> userPets = [];
  
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _loadUserPets(); // Cargar las mascotas al inicializar el widget
  }

  // Método para cargar las mascotas del usuario
  void _loadUserPets() async {
  List<Map<String, dynamic>> pets = await GetPetInfo.getUserPetsInfo();
  setState(() {
    userPets = pets;
  });
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
        body = HomeContent(userPets: userPets); // Pasar la lista de mascotas al HomeContent
        break;
      case 1:
        body = Search(index: 1);
        break;
      case 2:
        body = Notifications(index: 2);
        break;
      case 3:
        body = Profile(index: 3);
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
              icon: Icon(Icons.notifications),
              label: 'Notificaciones',
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
  final List<Map<String, dynamic>> userPets; // Lista de mascotas

  const HomeContent({Key? key, required this.userPets}) : super(key: key);

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
                showBackButton: false,
              ),
              SizedBox(height: 20),
            
              userPets.isNotEmpty
          ? Column(
              children: userPets.map((pet) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Verificar si la clave 'id' existe antes de acceder a ella
                      if (pet.containsKey('id')) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Pets(petId: pet['id'])),
                        );
                      } else {
                        print('El mapa no tiene la clave \'id\'');
                      }
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          CircleAvatar(
                            backgroundImage: NetworkImage(pet['imageUrl']),
                            radius: 40,
                          ),
                          SizedBox(width: 10),
                          Text(
                            pet['name'],
                            style: TextsFont.tituloNames,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )
            : Text(
                'No tiene mascotas registradas',
                style: TextStyle(fontSize: 16),
              ),
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
                      style: TextsFont.tituloNames,
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
