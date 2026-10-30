import 'package:flutter/cupertino.dart';

class FieldLabel extends StatelessWidget {
  const FieldLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
    );
  }
}