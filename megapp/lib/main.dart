import 'package:flutter/material.dart';
import 'package:megapp/homepage.dart';
import 'package:megapp/newtrip.dart';
//import 'package:meg_app/trippage.dart';
//import 'widgies.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage(), routes: {
      'HomePage': (context) => HomePage(),
      'NewTrip': (context) => NewTrip(),
      //'TripPage': (context) => TripPage(),
      // 'ExpensesPage': (context) => ExpensesPage(),
    });
  }
}
