


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget borderedInput({
  required String hint,
  IconData? icon,
  int maxLines = 1,
}) {
  return TextField(
    maxLines: maxLines,
    style: const TextStyle(fontSize: 12),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 11, color: Color(0xFF98A2B3)),
      prefixIcon: icon == null
          ? null
          : Icon(icon, size: 17, color: const Color(0xFF98A2B3)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Color(0xFFE4E7EC)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Color(0xFFE4E7EC)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Color(0xFF1A7A4A)),
      ),
    ),
  );
}