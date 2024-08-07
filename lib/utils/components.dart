import 'package:brahimdb/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//////////////////////////////////// TIMER SCREEN //////////////////////////

//// select time tools
class SelectTime extends StatelessWidget {
  final Function onChanged;
  final String txt;

  SelectTime({this.onChanged, this.txt});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        MyPickerCustomize(onChanged: (value) {
          onChanged(value);
        }),
        Container(
          child: Text(
            txt,
            style: TextStyle(color: Colors.white54),
          ),
        ),
      ],
    );
  }
}

class MyPickerCustomize extends StatelessWidget {
  final Function onChanged;

  const MyPickerCustomize({Key key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.1,
      width: width / 4,
      child: CupertinoPicker(
        backgroundColor: Colors.transparent,
        itemExtent: 30,
        onSelectedItemChanged: (value) {
          onChanged(value);
        },
        children: [
          for (int i = 0; i < 60; i++)
            Text(
              "$i",
              style: TextStyle(color: Colors.white),
            )
        ],
      ),
    );
  }
}

///// buttons (go ,skip .... )
class ButtonsController extends StatelessWidget {
  final String txt;
  final Function onPressed;

  ButtonsController({this.txt, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(txt),
      color: Color(0xffBD4567),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onPressed: () {
        onPressed();
      },
    );
  }
}
