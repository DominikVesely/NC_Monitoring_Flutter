import 'package:flutter/material.dart';

typedef Widget AsyncSnapshopCallback(dynamic data);

FutureBuilder ncFutureBuilder({
  Future<dynamic> future,
  AsyncSnapshopCallback callback,
}) {
  return FutureBuilder(
    future: future,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          return new Text("loading....");
        default:
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          else {
            return callback(snapshot.data);
          }
      }
    },
  );
}
