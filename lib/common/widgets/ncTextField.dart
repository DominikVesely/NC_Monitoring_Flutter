import 'package:flutter/material.dart';

Widget ncTextField(
  String hintText, {
  bool obscureText = false,
  TextEditingController controller,
  void Function(String) onSubmitted
}) {
  return TextField(
    decoration: InputDecoration(hintText: hintText),
    obscureText: obscureText,
    controller: controller,
    onSubmitted: onSubmitted,
  );
}
