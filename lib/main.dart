import 'package:brahimdb/screens/timer_screen.dart';
import 'package:brahimdb/utils/constants.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: primaryColor),
      ),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (_) => HomeScreen(),
        TimerScreen.id: (_) => TimerScreen(),
      },
    );
  }
}
