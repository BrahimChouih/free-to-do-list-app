import 'package:brahimdb/components/sessions.dart';
import 'package:brahimdb/controllers/timer_controller.dart';
import 'package:brahimdb/utils/app_bar.dart';
import 'package:brahimdb/utils/components.dart';
import 'package:brahimdb/utils/constants.dart';
import 'package:brahimdb/utils/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PomodoroScreen extends StatelessWidget {
  static const id = "PomodoroScreen";

  TimerConrtoller timerConrtoller = Get.find<TimerConrtoller>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: Container(
        decoration: kBackgroundImage,
        child: SafeArea(
          child: GetBuilder<TimerConrtoller>(
            builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBarCustmize(context),
                Text(
                  timerConrtoller.working
                      ? timerConrtoller.inBreak
                          ? "You're in break"
                          : "You're in work"
                      : 'Nothing',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.timer),
                    SizedBox(width: Get.width * 0.05),
                    Text(
                      // '00 : 00',
                      '${timerConrtoller.minuts.toString().padLeft(2, '0')} : ${timerConrtoller.seconds.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IgnorePointer(
                  ignoring: timerConrtoller.working,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SelectTime(
                        txt: 'min.',
                        onChanged: (value) {
                          timerConrtoller.endMinuts = value;
                        },
                      ),
                      SelectTime(
                        txt: 'sec.',
                        onChanged: (value) {
                          timerConrtoller.endSeconds = value;
                        },
                      ),
                    ],
                  ),
                ),
                IgnorePointer(
                  ignoring: timerConrtoller.working,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Sessions : '),
                      SizedBox(
                        width: Get.width * 0.1,
                      ),
                      SessionsSelect(
                        initValue: timerConrtoller.sessions,
                        onChange: (value) {
                          timerConrtoller.sessions = value;
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ButtonsController(
                      txt: 'Skip tihs session',
                      onPressed: () {
                        timerConrtoller.skipThisSession();
                      },
                    ),
                    ButtonsController(
                      txt: !timerConrtoller.working ? 'GO' : 'Stop',
                      onPressed: () {
                        if (!timerConrtoller.working)
                          timerConrtoller.startWork();
                        else
                          timerConrtoller.stopTimer();
                      },
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
