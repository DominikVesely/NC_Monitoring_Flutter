import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<T> showDialogSingleButton<T>(BuildContext context, String title, String message, {String buttonLabel = 'OK', void Function() onPressed}) async {
  // flutter defined function
  if (context == null) return null; // nelze zavolat showDialog s null contextem
  
  if (onPressed == null) {
    onPressed = () {
      Navigator.of(context, rootNavigator: true).pop();
    };
  }

  return await showDialog(
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
            onPressed: () {
              if (onPressed != null) {
                onPressed();                
              }
              else {
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
          ),
        ],
      );
    },
  );
}