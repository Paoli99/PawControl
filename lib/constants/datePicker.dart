import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawcontrol/constants/colors.dart';

class DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final void Function(DateTime?)? onSelectDate;
  final void Function(BuildContext)? onTap;
  final String? placeholderText;
  final Color? borderColor;
  final Color? backgroundColor;

  const DatePickerField({
    Key? key,
    required this.selectedDate,
    required this.onSelectDate,
    this.onTap,
    this.placeholderText, 
    this.borderColor,
    this.backgroundColor,
  }) : super(key: key);

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      onSelectDate?.call(picked);
    }
  }

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
        child: InkWell(
          onTap: onTap != null ? () => onTap!(context) : () => _selectDate(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
            child: Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                        : placeholderText ?? '', // Usar el texto del marcador de posición
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
