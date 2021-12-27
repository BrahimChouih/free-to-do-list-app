import 'dart:io';

import 'package:brahimdb/screens/pomodoro_screen.dart';
import 'package:brahimdb/utils/exit.dart';
import 'package:flutter/material.dart';
import 'package:brahimdb/screens/home_screen.dart';
import 'package:brahimdb/utils/about.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      child: SafeArea(
        child: BackdropFilter(
          filter: kBlurFilter,
          child: Container(
            width: width - width * 0.4,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
              color: Colors.black54,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                drawerContent('Tasks', Icons.edit, () {
                  Navigator.of(context).pushReplacementNamed(HomeScreen.id);
                }),
                SizedBox(height: height * 0.05),
                drawerContent('Timer', Icons.timer, () {
                  // Navigator.of(context).pushReplacementNamed(TimerScreen.id);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => PomodoroScreen(),
                    ),
                  );
                }),
                SizedBox(height: height * 0.05),
                drawerContent('About', Icons.info, () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (_) {
                        return BackdropFilter(
                          filter: kBlurFilter,
                          child: aboutBrahim(_),
                        );
                      });
                }),
                SizedBox(height: height * 0.05),
                drawerContent('Exit', Icons.close, () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (_) {
                        return BackdropFilter(
                          filter: kBlurFilter,
                          child: exitApp(_),
                        );
                      });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

drawerContent(String txt, IconData icon, Function onPreesed) {
  return Card(
    color: Color(0xffBD4567).withOpacity(0.3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    child: FlatButton(
      highlightColor: Colors.transparent,
      onPressed: () {
        onPreesed();
      },
      child: Column(
        children: <Widget>[
          SizedBox(height: height * 0.03),
          Icon(icon),
          SizedBox(height: height * 0.01),
          Text(txt),
          SizedBox(height: height * 0.03),
        ],
      ),
    ),
  );
}
