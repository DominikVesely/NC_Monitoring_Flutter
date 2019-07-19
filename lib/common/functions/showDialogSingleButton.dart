import 'package:flutter/material.dart';

void showDialogSingleButton(BuildContext context, String title, String message, {String buttonLabel = 'OK', void Function() onPressed}) {
  // flutter defined function
  if (context == null) return; // nelze zavolat showDialog s null contextem
  
  if (onPressed == null) {
    onPressed = () {
      Navigator.of(context).pop();
    };
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(title),
        content: new Text(message),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text(buttonLabel),
            onPressed: onPressed,
          ),
        ],
      );
    },
  );
}