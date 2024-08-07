import 'package:flutter/material.dart';

AlertDialog aboutBrahim(context) {
  return AlertDialog(
    backgroundColor: Colors.black54,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    title: Text("INFO"),
    content: Text(
        "programmer : Brahim CHOUIH \nFb: brahim.chouih \nemail: brahim26chouih@gamil.com"),
    actions: <Widget>[
      FlatButton(
        child: Text('ok'),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  );
}
