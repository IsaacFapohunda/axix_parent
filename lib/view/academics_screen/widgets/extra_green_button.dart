import 'package:flutter/material.dart';

import '../switch _child_screen.dart';

Widget extraGreenButton(
    String label,
    VoidCallback? onPressed) {
  return SizedBox(
    width: double.infinity,
    height: 44,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: academicsGreen,
        foregroundColor: Colors.white,
        disabledBackgroundColor: const Color(0xFF9DBDAB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
      ),
    ),
  );
}