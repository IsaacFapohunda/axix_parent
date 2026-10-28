//
// import 'package:flutter/cupertino.dart';
//
// class StaticChip extends StatelessWidget {
//   final String label;
//   final bool selected;
//
//   const StaticChip({
//     required this.label,
//     this.selected = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
//       decoration: BoxDecoration(
//         color: selected ? const Color(0xFF1A7A4A) : Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: selected
//               ? const Color(0xFF1A7A4A)
//               : const Color(0xFFE4E7EC),
//         ),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           fontSize: 10,
//           color: selected ? Colors.white : const Color(0xFF67707E),
//         ),
//       ),
//     );
//   }
// }