import 'package:brahimdb/screens/project_tasks.dart';
import 'package:brahimdb/screens/timer_screen.dart';
import 'package:brahimdb/timer.dart';
import 'package:flutter/material.dart';

class SessionsSelect extends StatefulWidget {
  Function timerController;

  SessionsSelect(this.timerController);

  @override
  _SessionsSelectState createState() => _SessionsSelectState();
}

class _SessionsSelectState extends State<SessionsSelect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white54),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          plusMinus(Icons.add),
          SizedBox(width: width * 0.05),
          Text(numSession.toString()),
          SizedBox(width: width * 0.05),
          plusMinus(Icons.remove),
        ],
      ),
    );
  }

  Widget plusMinus(IconData icon) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        if (!MyTimer.activate) {
          setState(() {
            icon == Icons.add
                ? numSession++
                : numSession > 1 ? numSession-- : {};
          });
          numBreak = numSession - 1;
        } else {
          widget.timerController();
        }
      },
    );
  }
}
