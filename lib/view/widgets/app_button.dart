import 'package:flutter/material.dart';



class AppButton extends StatelessWidget {
  VoidCallback onPressed;
  String label;
  Color buttonColor;
  Color? borderColor;
  TextStyle textStyle;
  AppButton({
    required this.onPressed,
    required this.label,
    required this.buttonColor,
    this.borderColor,
    required this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size height = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            border: borderColor != null ? Border.all(color: borderColor!) : null,
            borderRadius: BorderRadius.circular(8),
            color: buttonColor
        ),
        child: Center(
          child: Text(
            label,
            style: textStyle,
            ),
          ),
        ),
      );

  }
}