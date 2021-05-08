import 'package:flutter/material.dart';
import 'package:todoapp/screens/homescreen.dart';

void main() => runApp(Homepage());

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Color(0xffF3F3F3),
        primaryColor: Color(0xff4285F4),
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
