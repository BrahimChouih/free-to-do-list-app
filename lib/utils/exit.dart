import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AlertDialog exitApp(context) {
  return AlertDialog(
    backgroundColor: Colors.black54,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    title: Text("Exit"),
    content: Text("are you sure ??"),
    actions: <Widget>[
      FlatButton(
        child: Text('Yes'),
        onPressed: () {
//          exit(0);
          SystemNavigator.pop();
          Navigator.pop(context);
        },
      ),
      FlatButton(
        child: Text('No'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );
}
