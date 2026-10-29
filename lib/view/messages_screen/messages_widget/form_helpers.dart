
import 'package:flutter/cupertino.dart';

class SectionHeading extends StatelessWidget {
  final String title;
  final String count;

  const SectionHeading({
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          count,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF1A7A4A),
          ),
        ),
      ],
    );
  }
}