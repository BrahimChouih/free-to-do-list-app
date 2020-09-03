import 'dart:async';

class MyTimer {
  int endSeconds;
  int endMinutes;

  int nowSeconds = 0;
  int nowMinutes = 0;

  static bool activate = false;

  Function refresh;

  Timer mainTimer;
  Timer secondTimer;

  MyTimer({
    this.endSeconds = 0,
    this.endMinutes = 0,
    this.refresh,
  });
  start() {
    nowSeconds = endSeconds;
    nowMinutes = endMinutes;

    activate = true;
    showTimer();
  }

  Future<void> showTimer() async {
    mainTimer = Timer(
      Duration(
        seconds: endSeconds,
        minutes: endMinutes,
      ),
      () {
        activate = false;
      },
    );

    // refreshing and get time now

    secondTimer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (!activate) {
          refresh(true);
          timer.cancel();
          mainTimer.cancel();
        } else {
          if (nowSeconds < 1) {
            nowSeconds = 60;
            nowMinutes--;
          }
          if (nowMinutes < 0) {
            nowMinutes = 59;
          }
          print("m:$nowMinutes s:${--nowSeconds}");
          refresh(false);
        }
      },
    );
  }
}
