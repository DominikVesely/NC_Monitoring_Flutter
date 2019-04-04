import 'package:flutter/material.dart';

Widget ncButton(String buttonText, {
    @required VoidCallback onPressed,
  }) {  
  return FlatButton(
    child: Text(buttonText),
    onPressed: onPressed,
  );
}