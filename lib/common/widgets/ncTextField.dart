import 'package:flutter/material.dart';

Widget ncTextField(
  String hintText, {
  bool obscureText = false,
  TextEditingController controller,
}) {
  return TextField(
    decoration: InputDecoration(hintText: hintText),
    obscureText: obscureText,
    controller: controller,
  );
}
