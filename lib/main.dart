import 'package:brahimdb/screens/timer_screen.dart';
import 'package:flutter/material.dart';
import 'screens/project_tasks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        accentColor: Color(0xffBD4567),
        cursorColor: Color(0xffBD4567),
      ),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (_) => HomeScreen(),
        TimerScreen.id: (_) => TimerScreen(),
      },
    );
  }
}
