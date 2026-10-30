import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget sheet(BuildContext context, {required Widget child}) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
    ),
    padding: EdgeInsets.fromLTRB(
      20,
      10,
      20,
      20 + MediaQuery.of(context).viewPadding.bottom,
    ),
    child: SafeArea(
      top: false,
      child: child,
    ),
  );
}