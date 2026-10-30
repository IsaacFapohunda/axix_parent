
import 'package:flutter/material.dart';

Widget outlinedText(String value, {bool readOnly = false}) {
  return TextField(
    readOnly: readOnly,
    controller: TextEditingController(text: value),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: Color(0xFFE2E6EA)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: Color(0xFFE2E6EA)),
      ),
    ),
  );
}