import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget greenButton({
  required String label,
  required VoidCallback onTap,
  IconData? icon,
}) {
  return SizedBox(
    width: double.infinity,
    height: 44,
    child: ElevatedButton.icon(
      onPressed: onTap,
      icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 22, color: Color(0xFFF9F9F9)),
      label: Text(label, style: const TextStyle(fontSize: 16, color: Color(0xFFF9F9F9))),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1A7A4A),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    ),
  );
}