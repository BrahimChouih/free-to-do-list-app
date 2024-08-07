import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:brahimdb/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerConrtoller extends GetxController {
  bool working = false;
  int seconds = 0;
  int minuts = 0;
  int sessions = 0;
  int endSeconds = 0;
  int endMinuts = 0;

  bool inBreak = false;
  Timer timer;

  void startWork() async {
    working = true;
    startTimer();
  }

  void startTimer({bool isBreak = false}) {
    if (!isBreak) {
      if (sessions > 0) sessions--;
      seconds = endSeconds;
      minuts = endMinuts;
    } else {
      minuts = (endMinuts * 0.2).toInt();
      seconds = (((endMinuts * 60 + endSeconds) * 0.2) - minuts).toInt();
    }
    working = true;
    update();
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (minuts == 0 && seconds == 0) {
          working = false;
          timer.cancel();
          update();
          playSound();
          nextSession(isBreak: isBreak);
        } else {
          if (seconds < 1) {
            seconds = 59;
            minuts--;
          } else {
            seconds--;
          }
          print("m:$minuts s:$seconds");
          update();
        }
      },
    );
  }

  void nextSession({bool isBreak = false}) {
    if (sessions > 0 && !isBreak) {
      Get.dialog(
        CustomDialog(
          title: 'Wait',
          message: 'Do you want stat break ??',
          onNo: () => Get.back(),
          onYes: () {
            inBreak = true;
            startTimer(isBreak: true);
            Get.back();
          },
        ),
      );
    }
    if (sessions > 0 && isBreak) {
      Get.dialog(
        CustomDialog(
          title: 'Wait',
          message: 'Do you want stat Work ??',
          onNo: () => Get.back(),
          onYes: () {
            inBreak = false;
            startTimer(isBreak: false);
            Get.back();
          },
        ),
      );
    }
    if (sessions == 0) {
      working = false;
      inBreak = false;
      update();
      Get.snackbar('Done', 'Your sessions are over, Great job',
          backgroundColor: Colors.black54);
    }
  }

  void playSound() {
    try {
      final player = AudioCache();
      player.play("audio/finish.wav");
    } catch (e) {
      print(e);
    }
  }

  void skipThisSession() {
    if (working) {
      Get.dialog(
        CustomDialog(
          title: 'Wait',
          message: 'Do you want skip this session ??',
          onNo: () => Get.back(),
          onYes: () {
            timer.cancel();
            sessions++;
            startTimer();
            Get.back();
          },
        ),
      );
    }
  }

  void stopTimer() {
    seconds = 0;
    minuts = 0;
    working = false;
    inBreak = false;
    timer.cancel();
    update();
  }
}
