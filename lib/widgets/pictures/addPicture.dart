import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';

class AddPicture extends StatelessWidget {
  final String imageUrl;
  final void Function(String) setImageUrl;
  final void Function()? onPressed;

  const AddPicture({
    Key? key,
    required this.imageUrl,
    required this.setImageUrl,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(width: 4, color: Colors.white70),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 10,
                color: Colors.black87.withOpacity(0.1),
              ),
            ],
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  )
                : Icon(
                    Icons.person,
                    size: 100,
                    color: ColorsApp.white70,
                  ),
          ),
        ),
        if (onPressed != null)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 4,
                  color: ColorsApp.white70,
                ),
                color: ColorsApp.grey400,
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.edit,
                  color: ColorsApp.white,
                ),
                onPressed: onPressed,
              ),
            ),
          ),
      ],
    );
  }
}
