import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/buttons.dart';
import 'package:pawcontrol/constants/fonts.dart';

class SecondaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const SecondaryButton({Key? key, this.onPressed, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ButtonStyles.buttonHeight,
      width: ButtonStyles.buttonWidth, 
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Text(
          title,
          style: TextsFont.secondaryButton,
        ),
      ),
    );
  }
}