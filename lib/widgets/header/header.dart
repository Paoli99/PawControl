import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/asset_images.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';

class Header extends StatelessWidget {
  final String title;
  final VoidCallback? onLogoutPressed; 
  final bool showLogoutButton; 
  final bool showImage; 
  final bool showBackButton; 
  final Function(BuildContext)? navigateTo; // Cambio: Ahora es opcional

  const Header({
    Key? key,
    required this.title,
    this.onLogoutPressed,
    this.showLogoutButton = false,
    this.showImage = true,
    this.showBackButton = true,
    this.navigateTo, // Cambio: Ahora es opcional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: ColorsApp.white70,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          if (showBackButton && navigateTo != null) // Cambio: Verifica si navigateTo es no nulo
            IconButton(
              icon: Icon(Icons.arrow_back), 
              onPressed: () {
                navigateTo!(context); // Cambio: Usa navigateTo solo si no es nulo
              },
            ),
          if (showImage) 
            SizedBox(width: 20), 
          if (showImage) 
            Container( 
              width: 40, 
              height: 40, 
              child: Image.asset(
                AssetsImages.instance.logo,
                fit: BoxFit.fill,
              ),
            ),
          SizedBox(width: 10), 
          Expanded(
            child: Text(
              title,
              textAlign: showImage ? TextAlign.start : TextAlign.center, 
              style: TextsFont.tituloHeaderSmall,
            ),
          ),
          if (showLogoutButton) 
            IconButton(
              icon: Icon(
                Icons.logout_outlined,
                color: Colors.black87,
              ),
              onPressed: onLogoutPressed,
            ),
        ],
      ),
    );
  }
}
