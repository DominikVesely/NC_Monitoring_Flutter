import 'package:flutter/material.dart';

typedef Widget AsyncSnapshopCallback<T>(T data);

FutureBuilder ncFutureBuilder<T>({
  Future<T> future,
  AsyncSnapshopCallback<T> callback,
}) {
  return FutureBuilder(
    future: future,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      Widget result;
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          result = CircularProgressIndicator();
          break;
        default:
          if (snapshot.hasError)
            result = Text('Error: ${snapshot.error}');
          else {
            return callback(snapshot.data);
          }
          break;
      }

      return Center(
        child: result,
      );
    },
  );
}
