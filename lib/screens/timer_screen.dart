import 'package:audioplayers/audio_cache.dart';
import 'package:brahimdb/screens/project_tasks.dart';
import 'package:brahimdb/timer.dart';
import 'package:brahimdb/utils/app_bar.dart';
import 'package:brahimdb/utils/components.dart';
import 'package:brahimdb/utils/constants_timer_screen.dart';
import 'package:brahimdb/utils/drawer.dart';
import 'package:brahimdb/utils/sessions.dart';
import 'package:flutter/material.dart';

int numSession = 1;
int numBreak = 0;
List number = [];

MyTimer myTimer = MyTimer();

String nowM = '00';
String nowS = '00';

int endM = 0;
int endS = 0;

int endMLast = 0;
int endSLast = 0;

int endMLastBreak = 0;
int endSLastBreak = 0;

class TimerScreen extends StatefulWidget {
  static const id = 'timerScreen';
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  updateUi({bool finish = false}) {
    try {
      setState(() {
        if (myTimer != null) {
          nowM = (myTimer.nowMinutes).toString().padLeft(2, '0');
          nowS = (myTimer.nowSeconds).toString().padLeft(2, '0');
        }
        if (finish) {
          nowM = '00';
          nowS = '00';

          ////// start last session
          if (numBreak > 0) {
            finishSession(context, 'start', startTimer: timerController);
          }
        }
      });
      if (finish) {
        final player = AudioCache();
        player.play("audio/finish.wav");
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    updateUi();
    if (number != []) {
      for (int i = 0; i < 60; i++) {
        number.add(i);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
//    MyTimer.activate = false;
//    myTimer.mainTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: Container(
        decoration: kBackgroundImage,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppBarCustmize(context),
              Text(
                !MyTimer.activate
                    ? "Nothing"
                    : numSession > numBreak
                        ? "You're in work"
                        : "You're in brake",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.timer),
                  SizedBox(width: width * 0.05),
                  Text(
                    '$nowM : $nowS',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SelectTime(
                    txt: 'min.',
                    onChanged: (value) {
                      if (MyTimer.activate) {
                        timerController();
                      } else {
                        endM = value;
                      }
                    },
                  ),
                  SelectTime(
                    txt: 'sec.',
                    onChanged: (value) {
                      if (MyTimer.activate) {
                        timerController();
                      } else {
                        endS = value;
                      }
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Sessions : '),
                  SizedBox(
                    width: width * 0.1,
                  ),
                  SessionsSelect(timerController),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonsController(
                    txt: 'Skip tihs session',
                    onPressed: () {
                      if (numSession > 1 && MyTimer.activate) {
                        finishSession(
                          context,
                          'skip',
                          startTimer: timerController,
                        );
                      }
                    },
                  ),
                  ButtonsController(
                    txt: MyTimer.activate ? 'Stop' : 'GO',
                    onPressed: () {
                      timerController();
                    },
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
            ],
          ),
        ),
      ),
    );
  }

  void timerController() {
    if (!MyTimer.activate) {
      if (numSession > numBreak) {
        endMLast = endM;
        endSLast = endS;
      } else {
        endMLast = (endM * 0.2).toInt();
        endSLast = (endS * 0.2).toInt();
      }
      myTimer = MyTimer(
        endMinutes: endMLast,
        endSeconds: endSLast,
        refresh: (bool finish) {
          updateUi(finish: finish);
        },
      );
      myTimer.start();
    } else {
      finishSession(context, 'stop');
    }
    updateUi();
  }

  void finishSession(_, String mode, {Function startTimer}) {
    showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: kBlurFilter,
            child: restartTimer(_, mode, () {
              startTimer();
            }),
          );
        });
  }
}
