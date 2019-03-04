import 'package:flutter/material.dart';

Widget ncTextField(String hintText, {bool obscureText = false}) {
  return TextField(
    decoration: InputDecoration(hintText: hintText),
    obscureText: obscureText,
  );
}
