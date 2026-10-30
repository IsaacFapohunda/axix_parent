import 'package:flutter/cupertino.dart';

Widget sheetHandle() {
  return Center(
    child: Container(
      width: 38,
      height: 4,
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFD9DEE3),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}