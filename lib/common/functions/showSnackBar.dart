import 'package:flutter/material.dart';

enum SnackBarType { Success, Error, Warning, Info }

showSnackBar(BuildContext context, {@required String text, int seconds = 1, SnackBarType type = SnackBarType.Info}) {

  Color bgColor;

  switch (type) {
    case SnackBarType.Error:
      bgColor = Colors.red;
      break;

    case SnackBarType.Warning:
      bgColor = Colors.yellowAccent;
      break;
    case SnackBarType.Success:
      bgColor = Colors.green;
      break;
    
    default:
      bgColor = Colors.blueGrey;
  }

  Scaffold.of(context).showSnackBar(new SnackBar(
    content: Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: new Text(text),
    ),
    backgroundColor: bgColor,    
    duration: Duration(seconds: seconds),    
  ));
}