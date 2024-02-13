import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';

class DropDownListView<T> extends StatelessWidget {
  final String label;
  final Widget? prefixIcon;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final void Function(T?)? onChanged;
  final Color? borderColor;
  final Color? backgroundColor;

  const DropDownListView({
    Key? key,
    required this.label,
    this.prefixIcon,
    required this.items,
    required this.onChanged,
    this.value,
    this.borderColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color enabledBorderColor = borderColor ?? Colors.transparent;
    Color focusedBorderColor = borderColor ?? Colors.transparent;
    Color filledColor = backgroundColor ?? ColorsApp.white70;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Container(
        decoration: BoxDecoration(
          color: filledColor,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: ColorsApp.grey300,
              blurRadius: 25,
            ),
          ],
          border: borderColor != null ? Border.all(color: borderColor!, width: 1.0) : null,
        ),
        child: DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: filledColor,
            hintText: label,
            contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: enabledBorderColor),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focusedBorderColor),
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }
}
