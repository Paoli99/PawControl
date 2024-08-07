// pet_detail_popup.dart
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:pawcontrol/constants/colors.dart';
import 'package:pawcontrol/constants/fonts.dart';
import 'package:pawcontrol/screens/home/search.dart';
import 'package:flutter/src/material/carousel.dart';

class PetFormDetailPopup extends StatefulWidget {
  final Pet pet;

  const PetFormDetailPopup({Key? key, required this.pet}) : super(key: key);

  @override
  _PetFormDetailPopupState createState() => _PetFormDetailPopupState();
}

class _PetFormDetailPopupState extends State<PetFormDetailPopup> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 350, 
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(
                        widget.pet.imageUrls[index],
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.grey[300],
                            child: Icon(Icons.broken_image),
                          );
                        },
                      );
                    },
                    itemCount: widget.pet.imageUrls.length,
                    pagination: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        activeColor: Colors.white.withOpacity(0.9),
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    onIndexChanged: (index) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  widget.pet.isFoundPet ? "Mascota Encontrada" : "Mascota Extraviada",
                  style: TextStyle(color: ColorsApp.rojoGoogle, fontWeight: FontWeight.bold, fontSize: 20),
                ),
                if (!widget.pet.isFoundPet) buildDetailRow("Nombre:", widget.pet.name),
                buildDetailRow("Especie:", widget.pet.species),
                buildDetailRow("Raza:", widget.pet.breed),
                buildDetailRow("Género:", widget.pet.gender),
                buildDetailRow("Fecha:", widget.pet.date),
                buildDetailRow("Ubicación:", widget.pet.location),
                buildDetailRow("Descripción:", widget.pet.description),
                buildDetailRow("Teléfono:", widget.pet.phone.toString()),
                SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            right: 10.0,
            top: 10.0,
            child: Container(
              width: 30.0, 
              height: 30.0,
              decoration: BoxDecoration(
                color: ColorsApp.grey400,
                shape: BoxShape.circle,
              ),
              child: Center( 
                child: IconButton(
                  iconSize: 25.0, 
                  padding: EdgeInsets.zero, 
                  icon: Icon(Icons.close, color: ColorsApp.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black), 
          children: [
            TextSpan(text: "$label ", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value, style: TextStyle(fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}