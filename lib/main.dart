import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/contant.dart';
import 'package:todoapp/controllers/home_controller.dart';
import 'package:todoapp/controllers/task_data_controller.dart';
import 'package:todoapp/screens/homescreen.dart';

void main() => runApp(Homepage());

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskData(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeCrontroller(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: kBackgroundColor,
          primaryColor: kPrimaryColor,
          textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
