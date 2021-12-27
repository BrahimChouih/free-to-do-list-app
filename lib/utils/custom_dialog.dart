import 'package:flutter/material.dart';

import 'constants.dart';

class CustomDialog extends StatelessWidget {
  String title;
  String message;
  Function onYes;
  Function onNo;
  CustomDialog({this.title, this.message, this.onYes, this.onNo});
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: kBlurFilter,
      child: AlertDialog(
        backgroundColor: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(title ?? ''),
        content: Text(message ?? ''),
        actions: <Widget>[
          TextButton(
            child: Text("Yes"),
            onPressed: onYes,
          ),
          TextButton(
            child: Text("No"),
            onPressed: onNo,
          ),
        ],
      ),
    );
  }
}
