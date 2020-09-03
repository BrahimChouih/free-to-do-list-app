import 'package:flutter/material.dart';

AlertDialog aboutTask(context, {String title, String description, int done}) {
  final completed = done != 0 ? 'Yes' : 'No';
  return AlertDialog(
    backgroundColor: Colors.black54,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    title: Text("About $title"),
    content: Text("Description : $description \n\n Completed : $completed"),
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
