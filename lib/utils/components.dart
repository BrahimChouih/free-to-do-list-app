import 'package:brahimdb/screens/project_tasks.dart';
import '../timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brahimdb/screens/timer_screen.dart';

//////////////////////////////////// TIMER SCREEN //////////////////////////

//// if you want stop timer  (Dialog)
AlertDialog restartTimer(_, String mode, [Function startTimer]) {
  return AlertDialog(
    backgroundColor: Colors.black54,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    title: Text("Wait"),
    content: Text(
      mode == 'stop'
          ? "Do you want stop work ??"
          : (numSession > numBreak)
              ? "Do you want stat break ??"
              : "Do you want stat work ??",
    ),
    actions: <Widget>[
      FlatButton(
        child: Text("Yes"),
        onPressed: () {
          if (mode == 'stop') {
            /// if click stop button
            MyTimer.activate = false;
            numSession = 1;
            numBreak = 0;
          } else {
            if (mode == 'skip') {
              ////// if click skip button
              myTimer.mainTimer.cancel();
              myTimer.secondTimer.cancel();
              MyTimer.activate = false;
            }
            if (numSession > numBreak) {
              numSession != 1 ? numSession-- : {};
            } else {
              numBreak--;
            }
            startTimer();
          }
          print("numSession : $numSession");
          print("numBreak : $numBreak");
          Navigator.pop(_);
        },
      ),
      FlatButton(
        child: Text("No"),
        onPressed: () {
          Navigator.pop(_);
        },
      ),
    ],
  );
}

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
        children: number.map((f) {
          return Text(
            "$f",
            style: TextStyle(color: Colors.white),
          );
        }).toList(),
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
